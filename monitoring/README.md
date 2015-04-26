# Monitoring

The goal of this workshop is to establish some basic principles related to establishing a monitoring infrastructure.  Based on this we can begin exploring some simple resilience testing.

A new technology that you have not been previously exposed to is [socket.io](http://socket.io/).

### Setup

Clone this repository, run `npm install`.

Run `node main.js` to run the server.

Run `open www/index.html` or `start www/index.html` to open the monitoring application. 

There is code running every 2 seconds that will broad cast basic stats to the web app:

		setInterval( function () 
		{
			io.sockets.emit('heartbeat', 
			{ 
		        name: "Your Computer", cpu: cpuAverage(), memoryLoad: memoryLoad(),
		        nodes: calcuateColor()
		   });
		
		}, 2000);

### Calculate Memory Load

Modify `function memoryLoad()` to calculate the amount of memory currently used by the system.

### Calculate CPU Load

Modify `function cpuAverage()` to calculate the amount of load the cpu is under, between two successive samples.

### Calculate Latency

You have three servers running, on 9000, 9001, and 9002.

Modify `function measureLatenancy()` to calculate the time between making a request, and receiving a response.

[Useful example, using websockets (you can use regular http request)](http://stackoverflow.com/questions/4071258/how-can-i-find-the-response-time-latency-of-a-client-in-nodejs-with-sockets-s)

### Latency Monkey

**Latency Monkey** induces artificial delays client-server communication layer to simulate service degradation and measures if upstream services respond appropriately. In addition, by making very large delays, you can simulate a node or even an entire service downtime (and test our ability to survive it) without physically bringing these instances down. This can be particularly useful when testing the fault-tolerance of a new service by simulating the failure of its dependencies, without making these dependencies unavailable to the rest of the system.

*Implement a basic Latency Monkey by introducing randomly large delays using a proxy to the three servers.*

### Chaos Monkey

**Chaos Monkey**, a tool that randomly disables our production instances to make sure we can survive this common type of failure without any customer impact. The name comes from the idea of unleashing a wild monkey with a weapon in your data center (or cloud region) to randomly shoot down instances and chew through cables -- all the while we continue serving our customers without interruption.

*Implement a basic Chaos Monkey by blocking routes to a specific server.*
