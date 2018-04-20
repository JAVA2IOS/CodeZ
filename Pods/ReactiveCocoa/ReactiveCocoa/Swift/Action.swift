import Foundation
import enum Result.NoError

/// Represents an action that will do some work when executed with a value of
/// type `Input`, then return zero or more values of type `Output` and/or fail
/// with an error of type `Error`. If no failure should be possible, NoError can
/// be specified for the `Error` parameter.
///
/// Actions enforce serial execution. Any attempt to execute an action multiple
/// times concurrently will return an error.
public final class Action<Input, Output, Error: ErrorType> {
	private let executeClosure: Input -> SignalProducer<Output, Error>
	private let eventsObserver: Signal<Event<Output, Error>, NoError>.Observer

	/// A signal of all events generated from applications of the Action.
	///
	/// In other words, this will send every `Event` from every signal generated
	/// by each SignalProducer returned from apply().
	public let events: Signal<Event<Output, Error>, NoError>

	/// A signal of all values generated from applications of the Action.
	///
	/// In other words, this will send every value from every signal generated
	/// by each SignalProducer returned from apply().
	public let values: Signal<Output, NoError>

	/// A signal of all errors generated from applications of the Action.
	///
	/// In other words, this will send errors from every signal generated by
	/// each SignalProducer returned from apply().
	public let errors: Signal<Error, NoError>

	/// Whether the action is currently executing.
	public var executing: AnyProperty<Bool> {
		return AnyProperty(_executing)
	}

	private let _executing: MutableProperty<Bool> = MutableProperty(false)

	/// Whether the action is currently enabled.
	public var enabled: AnyProperty<Bool> {
		return AnyProperty(_enabled)
	}

	private let _enabled: MutableProperty<Bool> = MutableProperty(false)

	/// Whether the instantiator of this action wants it to be enabled.
	private let userEnabled: AnyProperty<Bool>

	/// This queue is used for read-modify-write operations on the `_executing`
	/// property.
	private let executingQueue = dispatch_queue_create("org.reactivecocoa.ReactiveCocoa.Action.executingQueue", DISPATCH_QUEUE_SERIAL)

	/// Whether the action should be enabled for the given combination of user
	/// enabledness and executing status.
	private static func shouldBeEnabled(userEnabled userEnabled: Bool, executing: Bool) -> Bool {
		return userEnabled && !executing
	}

	/// Initializes an action that will be conditionally enabled, and create a
	/// SignalProducer for each input.
    public init<P: PropertyType>(enabledIf: P, _ execute: Input -> SignalProducer<Output, Error>) where P.Value == Bool {
		executeClosure = execute
		userEnabled = AnyProperty(enabledIf)

		(events, eventsObserver) = Signal<Event<Output, Error>, NoError>.pipe()

		values = events.map { $0.value }.ignoreNil()
		errors = events.map { $0.error }.ignoreNil()

		_enabled <~ enabledIf.producer
			.combineLatestWith(_executing.producer)
			.map(Action.shouldBeEnabled)
	}

	/// Initializes an action that will be enabled by default, and create a
	/// SignalProducer for each input.
	public convenience init(_ execute: Input -> SignalProducer<Output, Error>) {
		self.init(enabledIf: ConstantProperty(true), execute)
	}

	deinit {
		eventsObserver.sendCompleted()
	}

	/// Creates a SignalProducer that, when started, will execute the action
	/// with the given input, then forward the results upon the produced Signal.
	///
	/// If the action is disabled when the returned SignalProducer is started,
	/// the produced signal will send `ActionError.NotEnabled`, and nothing will
	/// be sent upon `values` or `errors` for that particular signal.
	@warn_unused_result(message="Did you forget to call `start` on the producer?")
	public func apply(input: Input) -> SignalProducer<Output, ActionError<Error>> {
		return SignalProducer { observer, disposable in
			var startedExecuting = false

			dispatch_sync(self.executingQueue) {
				if self._enabled.value {
					self._executing.value = true
					startedExecuting = true
				}
			}

			if !startedExecuting {
				observer.sendFailed(.NotEnabled)
				return
			}

			self.executeClosure(input).startWithSignal { signal, signalDisposable in
				disposable.addDisposable(signalDisposable)

				signal.observe { event in
					observer.action(event.mapError(ActionError.ProducerError))
					self.eventsObserver.sendNext(event)
				}
			}

			disposable += {
				self._executing.value = false
			}
		}
	}
}

public protocol ActionType {
	/// The type of argument to apply the action to.
	associatedtype Input
	/// The type of values returned by the action.
	associatedtype Output
	/// The type of error when the action fails. If errors aren't possible then `NoError` can be used.
	associatedtype Error: ErrorType

	/// Whether the action is currently enabled.
	var enabled: AnyProperty<Bool> { get }

	/// Extracts an action from the receiver.
	var action: Action<Input, Output, Error> { get }

	/// Creates a SignalProducer that, when started, will execute the action
	/// with the given input, then forward the results upon the produced Signal.
	///
	/// If the action is disabled when the returned SignalProducer is started,
	/// the produced signal will send `ActionError.NotEnabled`, and nothing will
	/// be sent upon `values` or `errors` for that particular signal.
	func apply(input: Input) -> SignalProducer<Output, ActionError<Error>>
}

extension Action: ActionType {
	public var action: Action {
		return self
	}
}

/// The type of error that can occur from Action.apply, where `Error` is the type of
/// error that can be generated by the specific Action instance.
public enum ActionError<Error: ErrorType>: ErrorType {
	/// The producer returned from apply() was started while the Action was
	/// disabled.
	case NotEnabled

	/// The producer returned from apply() sent the given error.
	case ProducerError(Error)
}

public func == <Error: Equatable>(lhs: ActionError<Error>, rhs: ActionError<Error>) -> Bool {
	switch (lhs, rhs) {
	case (.NotEnabled, .NotEnabled):
		return true

	case let (.ProducerError(left), .ProducerError(right)):
		return left == right

	default:
		return false
	}
}
