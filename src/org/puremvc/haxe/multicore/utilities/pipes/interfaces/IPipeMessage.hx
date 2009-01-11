/*
 PureMVC haXe/MultiCore Utility – Pipes Port by Marco Secchi <marco.secchi@puremvc.org>
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.haxe.multicore.utilities.pipes.interfaces;

/** 
 * Pipe Message Interface.
 *
 * <p>[IPipeMessage]s are objects written intoto a Pipeline, 
 * composed of [IPipeFitting]s. The message is passed from 
 * one fitting to the next in syncrhonous fashion.</p> 
 *
 * <p>Depending on type, messages may be handled  differently by the 
 * fittings.</p>
 */
interface IPipeMessage
{
	// Get the type of this message
	function getType(): String;

	// Set the type of this message
	function setType( type: String ): Void;
		
	// Get the priority of this message
	function getPriority(): Int;

	// Set the priority of this message
	function setPriority( priority: Int ): Void;
		
	// Get the header of this message
	function getHeader(): Dynamic;

	// Set the header of this message
	function setHeader( header: Dynamic ): Void;
		
	// Get the body of this message
	function getBody(): Dynamic;

	// Set the body of this message
	function setBody( body: Dynamic ): Void;
}