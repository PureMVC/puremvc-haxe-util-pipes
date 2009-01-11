/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.messages;

import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeMessage;

/**
 * Pipe Message.
 *
 * <p>Messages travelling through a Pipeline can
 * be filtered, and queued. In a queue, they may
 * be sorted by priority. Based on type, they 
 * may used as control messages to modify the
 * behavior of filter or queue fittings connected
 * to the pipleline into which they are written.</p>
 */ 
class Message implements IPipeMessage
{

	// High priority Messages can be sorted to the front of the queue 
	public static inline var PRIORITY_HIGH: Int		= 1;
	// Medium priority Messages are the default
	public static inline var PRIORITY_MED: Int		= 5;
	// Low priority Messages can be sorted to the back of the queue 
	public static inline var PRIORITY_LOW: Int		= 10;
		
	/**
	 * Normal Message type.
	 */
	private static inline var BASE: String			= 'http://puremvc.org/namespaces/pipes/messages/';
	public static inline var NORMAL: String 		= BASE + 'normal/';
		
	// TBD: Messages in a queue can be sorted by priority.
	private var priority: Int;

	// Messages can be handled differently according to type
	private var type: String;
		
	// Header properties describe any meta data about the message for the recipient
	private var header: Dynamic;

	// Body of the message is the precious cargo
	private var body: Dynamic;

	// Constructor
	public function new( type: String, ?header: Dynamic = null, ?body: Dynamic = null, ?priority: Int = 5 )
	{
		setType( type );
		setHeader( header );
		setBody( body );
		setPriority( priority );
	}
		
	// Get the type of this message
	public function getType(): String
	{
		return this.type;
	}
		
	// Set the type of this message
	public function setType( type: String ): Void
	{
		this.type = type;
	}
		
	// Get the priority of this message
	public function getPriority(): Int
	{
		return priority;
	}

	// Set the priority of this message
	public function setPriority( priority: Int ): Void
	{
		this.priority = priority;
	}
		
	// Get the header of this message
	public function getHeader(): Dynamic
	{
		return header;
	}

	// Set the header of this message
	public function setHeader( header: Dynamic ): Void
	{
		this.header = header;
	}
		
	// Get the body of this message
	public function getBody(): Dynamic
	{
		return body;
	}

	// Set the body of this message
	public function setBody( body: Dynamic ): Void
	{
		this.body = body;
	}

}