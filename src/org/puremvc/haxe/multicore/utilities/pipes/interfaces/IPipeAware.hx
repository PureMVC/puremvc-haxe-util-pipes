/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.interfaces;
	
/**
 * Pipe Aware interface.
 *
 * <p>Can be implemented by any PureMVC Core that wishes
 * to communicate with other Cores using the Pipes 
 * utility.</p>
 */
interface IPipeAware
{
	function acceptInputPipe( name: String, pipe: IPipeFitting ): Void;
	function acceptOutputPipe( name: String, pipe: IPipeFitting ): Void;
}