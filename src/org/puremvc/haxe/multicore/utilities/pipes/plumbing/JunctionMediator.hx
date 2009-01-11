/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.plumbing;

import org.puremvc.haxe.multicore.interfaces.INotification;
import org.puremvc.haxe.multicore.patterns.mediator.Mediator;
import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeFitting;
import org.puremvc.haxe.multicore.utilities.pipes.interfaces.IPipeMessage;
import org.puremvc.haxe.multicore.utilities.pipes.messages.FilterControlMessage;
	
/**
 * Junction Mediator.
 *
 * <p>A base class for handling the Pipe Junction in an IPipeAware 
 * Core.</p>
 */
class JunctionMediator extends Mediator
{
	/**
	 * Accept input pipe notification name constant.
	 */ 
	public static inline var ACCEPT_INPUT_PIPE: String		= 'acceptInputPipe';
		
	/**
	 * Accept output pipe notification name constant.
	 */ 
	public static inline var ACCEPT_OUTPUT_PIPE: String		= 'acceptOutputPipe';

	/**
	 * Constructor.
	 */
	public function new( name: String, viewComponent: Junction )
	{
		super( name, viewComponent );
	}

	/**
	 * List Notification Interests.
	 *
	 * <p>Returns the notification interests for this base class.
	 * Override in subclass and call [super.listNotificationInterests]
	 * to get this list, then add any sublcass interests to 
	 * the array before returning.</p>
	 */
	override public function listNotificationInterests(): Array<String>
	{
		return [
				JunctionMediator.ACCEPT_INPUT_PIPE,
				JunctionMediator.ACCEPT_OUTPUT_PIPE
		       ];	
	}
		
	/**
	 * Handle Notification.
	 *
	 * <p>This provides the handling for common junction activities. It 
	 * accepts input and output pipes in response to [IPipeAware]
	 * interface calls.</p>
	 *
	 * <p>Override in subclass, and call [super.handleNotification]
	 * if none of the subclass-specific notification names are matched.</p>
	 */
	override public function handleNotification( note: INotification ): Void
	{
		switch( note.getName() )
		{
			// accept an input pipe
			// register the pipe and if successful 
			// set this mediator as its listener
			case JunctionMediator.ACCEPT_INPUT_PIPE:
				var inputPipeName: String = note.getType();
				var inputPipe: IPipeFitting = if ( Std.is( note.getBody(), IPipeFitting) ) note.getBody() else null;
				if ( junction.registerPipe( inputPipeName, Junction.INPUT, inputPipe ) ) 
				{
					junction.addPipeListener( inputPipeName, this, handlePipeMessage );		
				} 
				
			// accept an output pipe
			case JunctionMediator.ACCEPT_OUTPUT_PIPE:
				var outputPipeName: String = note.getType();
				var outputPipe: IPipeFitting = if ( Std.is( note.getBody(), IPipeFitting) ) note.getBody() else null;
				junction.registerPipe( outputPipeName, Junction.OUTPUT, outputPipe );
		}
	}
		
	/**
	 * Handle incoming pipe messages.
	 *
	 * <p>Override in subclass and handle messages appropriately for the module.</p>
	 */
	public function handlePipeMessage( message: IPipeMessage ): Void
	{
	}

	/**
	 * The Junction for this Module.
	 */
	private var junction( getJunction, null ): Junction;

	private function getJunction()
	{
		return if ( Std.is( viewComponent, Junction ) ) viewComponent else null;
	}
		

}