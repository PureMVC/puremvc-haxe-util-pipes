/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.interfaces;

/** 
 * Pipe Fitting Interface.
 *
 * <p>An [IPipeFitting] can be connected to other 
 * [IPipeFitting]s, forming a Pipeline. 
 * [IPipeMessage]s are written to one end of a 
 * Pipeline by some client code. The messages are then 
 * transfered in synchronous fashion from one fitting to 
 * the next.</p>
 */
interface IPipeFitting
{
	/**
	 * Connect another Pipe Fitting to the output.
	 *
	 * <p>Fittings connect and write to 
	 * other fittings in a one way syncrhonous
	 * chain, as water typically flows one direction 
	 * through a physical pipe.</p>
	 */
	function connect( output: IPipeFitting ): Bool;

	/**
	 * Disconnect the Pipe Fitting connected to the output.
	 *
	 * <p>This disconnects the output fitting, returning a 
	 * reference to it. If you were splicing another fitting
	 * into a pipeline, you need to keep (at least briefly) 
	 * a reference to both sides of the pipeline in order to 
	 * connect them to the input and output of whatever 
	 * fiting that you're splicing in.</p>
	 */
	function disconnect(): IPipeFitting;

	/**
	 * Write the message to the output Pipe Fitting.
	 *
	 * <p>There may be subsequent filters and tees
 	 * (which also implement this interface), that the 
 	 * fitting is writing to, and so a message
 	 * may branch and arrive in different forms at
 	 * different endpoints. </p>
 	 *
 	 * <p>If any fitting in the chain returns false 
 	 * from this method, then the client who originally 
 	 * wrote into the pipe can take action, such as 
 	 * rolling back changes.</p>
 	 */
	function write( message: IPipeMessage ): Bool;
			
}