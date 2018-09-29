function xmap(topics, links, max_layer) {
	var width = document.getElementById("map").clientWidth;
	var height = $(window).height()*0.8;

	// Style setting
	var base_r = width/80;
	var branch_color = "blue";
	var center_color = "orange";
	var from_color = "red";
	var text_color   = "blue";
	var line_width   = 2;
	var layer_width  = width / (max_layer+1) / 2;
	var layer_height = width / (max_layer+1) / 2;
	// Style setting

	var charge        = 0;
	var collide       = (layer_height > layer_width) ? layer_width *0.35 : layer_height*0.35;
	var link_distance = 0;
	
	var simulation = d3.forceSimulation()
										 .force("link", d3.forceLink())
									   .force("collide", d3.forceCollide( collide ) )
										 .force("charge", d3.forceManyBody())
										 .force("center", d3.forceCenter(width / 2, height / 2));

	//Append a SVG to the body of the html page. Assign this SVG as an object to svg
	var svg = d3.select("#map").append("svg")
	    				.attr("width", width)
							.attr("height", height);

	// Append arrow ar line end
			 svg.append("defs").selectAll("marker")
					.data(["arrow_branch"])
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
					.style("opacity", "0.5");
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

	var link = svg.append("g")
								.attr("class", "links")
								.selectAll("line")
								.data(links)
								.enter().append("line")
								.attr("stroke-width", line_width)
								.attr("stroke", function(d) { return (d.source == 0) ? center_color : branch_color;})
								.style("marker-end", function(d) { return (d.source == 0) ? "url(#arrow_center)" : "url(#arrow_branch)";});
	var node = svg.append("g")
								.selectAll("a")
								.data(topics)
								.enter()
								.append("a")
								.attr("xlink:href", function(d) { return "http://"+window.location.host+"/topics/"+d.base+"?center="+d.center+"&from="+d.from+"&page_num="+d.page+"&scale="+max_layer })
								.attr("class", "nodes")
								.append("circle")
								.attr("r", function(d) {return (d.type === "center") ? base_r*2.5 : base_r;} )
								.attr("fill", function(d) { return (d.type === "center") ? center_color : (d.type === "from") ? from_color : branch_color; })
								.attr('stroke','white')
								.attr('stroke-width',line_width)
								.call(d3.drag()
								.on("start", dragstarted)
								.on("drag", dragged)
								.on("end", dragended));
	var text = svg.selectAll("text")
								.data(topics)
								.enter()
								.append("text")
								.style("fill", text_color)
								.attr("dx", base_r)
								.attr("dy", base_r)
								.text(function(d){return d.name;});

	simulation
		.nodes(topics)
		.on("tick", ticked);

	simulation.force("link")
	  .links(links)
		.distance(function(d) {return link_distance;});

	simulation.force("charge").strength(charge);
	
	function ticked() {
		link
			.attr("x1", function(d) { return (d.layer  == 0) ?  width/2 : Math.max(20, Math.min(width -(base_r*2), d.source.x)); })
			.attr("y1", function(d) { return (d.layer  == 0) ? height/2 : Math.max(20, Math.min(height-(base_r*2), d.source.y)); })
			.attr("x2", function(d) { return (d.target == 0) ?  width/2 : Math.max(20, Math.min(width -(base_r*2), d.target.x)); })
			.attr("y2", function(d) { return (d.target == 0) ? height/2 : Math.max(20, Math.min(height-(base_r*2), d.target.y)); });
		node
			.attr("cx", function(d) { return (d.type === "center") ?  width/2 : Math.max(20, Math.min(width -(base_r*2), d.x)); })
			.attr("cy", function(d) { return (d.type === "center") ? height/2 : Math.max(20, Math.min(height-(base_r*2), d.y)); });
		text
			.attr("x", function(d) { return (d.type === "center") ?  width/2 : Math.max(20, Math.min(width -(base_r*2), d.x));})
			.attr("y", function(d) { return (d.type === "center") ? height/2 : Math.max(20, Math.min(height-(base_r*2), d.y));});
	};

	function dragstarted(d, i) {
		d.fixed = false;
	};

	function dragged(d, i) {
		d.fx = d3.event.x;
		d.fy = d3.event.y;
	}

	function dragended(d) {
		d.fixed = true; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
		simulation.alphaTarget(0.2).restart();
	};

}