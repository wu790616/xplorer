function xmap(/*svg, */topics, links, width, height, charge_null) {
	var color      = d3.scaleOrdinal().range(d3.schemeCategory20);
	
	// Style setting
	var base_r = width/50;
	var branch_color = "green";
	var center_color = "red";
	var text_color = "blue";
	var line_width = 2;
	var link_distance = base_r*10;
	var charge = 0;
	var collide = base_r*4;

	
	var simulation = d3.forceSimulation()
										 .force("link", d3.forceLink())
									   .force("collide", d3.forceCollide( collide ) )
										 .force("charge", d3.forceManyBody())
										 .force("center", d3.forceCenter(width / 2, height / 2));

	//Append a SVG to the body of the html page. Assign this SVG as an object to svg
	var svg = d3.select("#map").append("svg")
	    			//.attr("width", width)
						//.attr("height", height)
							.attr("viewBox", "0 0 " + width + " " + height);

	// Append arrow ar line end
			 svg.append("defs").selectAll("marker")
					.data(["arrow_barnch"])
					.enter().append("marker")
					.attr("id", function(d) { return d; })
					.attr("viewBox", "0 -5 10 10")
					.attr("refX", 25)
					.attr("refY", 0)
					.attr("markerWidth", 6)
					.attr("markerHeight", 6)
					.attr("orient", "auto")
					.append("path")
					.attr("d", "M0,-5L10,0L0,5 L10,0 L0, -5")
					.attr("stroke-width", line_width)
					.style("stroke", branch_color)
					.style("opacity", "0.6");
			 svg.append("defs").selectAll("marker")
					.data(["arrow_center"])
					.enter().append("marker")
					.attr("id", function(d) { return d; })
					.attr("viewBox", "0 -5 10 10")
					.attr("refX", 25)
					.attr("refY", 0)
					.attr("markerWidth", 6)
					.attr("markerHeight", 6)
					.attr("orient", "auto")
					.append("path")
					.attr("d", "M0,-5L10,0L0,5 L10,0 L0, -5")
					.attr("stroke-width", line_width)
					.style("stroke", center_color)
					.style("opacity", "0.6");

	var zoom = d3.zoom()
							 .scaleExtent([0.2, 10])
							 .on("zoom", zoomed);
		
//svg.call(zoom);

	var link = svg.append("g")
								.attr("class", "links")
								.selectAll("line")
								.data(links)
								.enter().append("line")
								.attr("stroke-width", line_width)
								.attr("stroke", function(d) { return (d.source == 0) ? center_color : branch_color;})
								.style("marker-end", function(d) { return (d.source == 0) ? "url(#arrow_center)" : "url(#arrow_barnch)";});
	var node = svg.append("g")
								.selectAll("a")
								.data(topics)
								.enter()
								.append("a")
								.attr("xlink:href", function(d) { return "http://"+window.location.host+"/topics/"+d.base+"?center="+d.center+"&from="+d.from+"&page_num="+d.page })
								.attr("class", "nodes")
								.append("circle")
								.attr("r", function(d) {return (d.type === "center") ? base_r*2 : base_r;} )
								.attr("fill", function(d) { return (d.type === "center") ? color(0) : color(1); })
								.attr('stroke','white')
								.attr('stroke-width',line_width)
								.call(d3.drag()
								.on("start", dragstarted)
								.on("drag", dragged)
								.on("end", dragended))
								.on('dblclick', releasenode);
	var text = svg.selectAll("text")
								.data(topics)
								.enter()
								.append("text")
								.style("fill", text_color)
								.attr("dx", 12)
								.attr("dy", 5)
								.text(function(d){return d.name;});
	

	simulation
		.nodes(topics)
		.on("tick", ticked);

	simulation.force("link")
	  .links(links)
		.distance(function(d) {return link_distance;});

//simulation.force("charge").strength(charge);
	simulation.force("charge").strength(charge);

	function ticked() {
		link
			.attr("x1", function(d) { return (d.layer == 0) ?  width/2 : Math.max(20, Math.min(width -50, d.source.x)); })
			.attr("y1", function(d) { return (d.layer == 0) ? height/2 : Math.max(20, Math.min(height-20, d.source.y)); })
			.attr("x2", function(d) { return Math.max(20, Math.min(width -50, d.target.x)); })
			.attr("y2", function(d) { return Math.max(20, Math.min(height-20, d.target.y)); });
		node
			.attr("cx", function(d) { return (d.type === "center") ?  width/2 : Math.max(20, Math.min(width -50, d.x)); })
			.attr("cy", function(d) { return (d.type === "center") ? height/2 : Math.max(20, Math.min(height-20, d.y)); });
		text
			.attr("x", function(d) { return (d.type === "center") ?  width/2 : Math.max(20, Math.min(width -50, d.x));})
			.attr("y", function(d) { return (d.type === "center") ? height/2 : Math.max(20, Math.min(height-20, d.y));});
	};

	function zoomed() {
		svg.attr('transform', 'scale(' + d3.event.transform.k + ')');
	}

	function dragstarted(d, i) {
	//simulation.stop() // stops the force auto positioning before you start dragging
		if (!d3.event.active) simulation.alphaTarget(0.3).restart();
			d.fx = d.x;
			d.fy = d.y;
	};

	function dragged(d) {
		d.fx = d3.event.x;
		d.fy = d3.event.y;
	};

	function dragended(d) {
	//	d.fixed = true; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
	//	simulation.restart();
		if (!d3.event.active) simulation.alphaTarget(0);
		d.fx = null;
		d.fy = null;
	};

	function releasenode(d) {
		d.fixed = false; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
	}
}