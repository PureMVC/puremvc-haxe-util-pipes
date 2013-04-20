/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.plumbing;

import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeFitting;
import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeMessage;
import org.puremvc.haxe.multicore.utilities.pipes.messages.Message;
import org.puremvc.haxe.multicore.utilities.pipes.messages.QueueControlMessage;
	
/** 
 * Pipe Queue.
 *
 * <p>The Queue always stores inbound messages until you send it
 * a FLUSH control message, at which point it writes its buffer 
 * to the output pipe fitting. The Queue can be sent a SORT 
 * control message to go into sort-by-priority mode or a FIFO 
 * control message to cancel sort mode and return the
 * default mode of operation, FIFO.</p>
 * 
 *
 * <p>NOTE: There can effectively be only one Queue on a given 
 * pipeline, since the first Queue acts on any queue control 
 * message. Multiple queues in one pipeline are of dubious 
 * use, and so having to name them would make their operation 
 * more complex than need be.</p> 
 */
class Queue extends Pipe
{

	/**
	 * Constructor.
	 */
	public function new( ?output: IPipeFitting = null )
	{
		super( output );
		mode = QueueControlMessage.SORT;
		messages = new Array();
	}
		
	/**
	 * Handle the incoming message.
	 *
	 * <p>Normal messages are enqueued.</p>
	 *
	 * <p>The FLUSH message type tells the Queue to write all 
	 * stored messages to the ouptut PipeFitting, then 
	 * return to normal enqueing operation.</p>
	 *
	 * <p>The SORT message type tells the Queue to sort all 
	 * <i>subsequent</i> incoming messages by priority. If there
	 * are unflushed messages in the queue, they will not be
	 * sorted unless a new message is sent before the next FLUSH.
	 * Sorting-by-priority behavior continues even after a FLUSH, 
	 * and can be turned off by sending a FIFO message, which is 
	 * the default behavior for enqueue/dequeue.</p> 
	 */ 
	override public function write( message: IPipeMessage ): Bool
	{
		var success: Bool = true;
		var messageType: String = message.getType();
		
		if (messageType == Message.NORMAL) 
		{
			// Store normal messages
			this.store( message );
		}
		else if (messageType == QueueControlMessage.FLUSH)
		{
			// Flush the queue
			success = this.flush();	
		}
		else if (messageType == QueueControlMessage.SORT)
		{
			// Put Queue into Priority Sort or FIFO mode 
			// Subsequent messages written to the queue
			// will be affected. Sorted messages cannot
			// be put back into FIFO order!
			mode = message.getType();
		}
		else if (messageType == QueueControlMessage.FIFO)
		{
			mode = message.getType();
		}
		
		return success;
	} 
		
	/**
	 * Store a message.
	 */
	private function store( message: IPipeMessage ): Void
	{
		messages.push( message );
		if (mode == QueueControlMessage.SORT ) messages.sort( sortMessagesByPriority );
	}

	/**
	 * Sort the Messages by priority.
	 */
	private function sortMessagesByPriority( msgA: IPipeMessage, msgB: IPipeMessage ): Int
	{
		var num: Int = 0;
		if ( msgA.getPriority() < msgB.getPriority() ) num = -1;
		if ( msgA.getPriority() > msgB.getPriority() ) num = 1;
		return num;
	}
	
	/**
	 * Flush the queue.
	 *
	 * <p>NOTE: This empties the queue.</p>
	 */
	private function flush(): Bool
	{
		var success: Bool = true;
		var message: IPipeMessage = messages.shift();
		while ( message != null ) 
		{
			var ok: Bool = output.write( message );
			if ( !ok ) success = false;
			message = messages.shift();
		} 
		return success;
	}

	private var mode: String;
	private var messages: Array<IPipeMessage>;
}