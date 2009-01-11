/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.messages;

/**
 * Queue Control Message.
 *
 * <p>A special message for controlling the behavior of a Queue.</p>
 *
 * <p>When written to a pipeline containing a Queue, the type
 * of the message is interpreted and acted upon by the Queue.</p>
 * 
 * <p>Unlike filters, multiple serially connected queues aren't 
 * very useful and so they do not require a name. If multiple
 * queues are connected serially, the message will be acted 
 * upon by the first queue only.</p>
 */ 
class QueueControlMessage extends Message
{
	private static inline var BASE: String		= Message.BASE + '/queue/'; 

	/**
	 * Flush the queue.
	 */
	public static inline var FLUSH: String		= BASE + 'flush';
		
	/**
	 * Toggle to sort-by-priority operation mode.
	 */
	public static inline var SORT: String		= BASE + 'sort';
		
	/**
	 * Toggle to FIFO operation mode (default behavior).
	 */
	public static inline var FIFO: String		= BASE + 'fifo';

	// Constructor
	public function new( type: String )
	{
		super( type  );
	}

}