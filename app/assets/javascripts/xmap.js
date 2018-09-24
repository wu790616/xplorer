function xmap(svg, topics, links, width, height, charge) {

	var color = d3.scaleOrdinal()
	 							.range(d3.schemeCategory20);
	var simulation = d3.forceSimulation()
										 .force("link", d3.forceLink())
										 .force("charge", d3.forceManyBody())
										 .force("center", d3.forceCenter(width / 2, height / 2));

	var zoom = d3.zoom()
							 .scaleExtent([1, 10])
							 .on("zoom", zoomed);
		
	svg.call(zoom);

	var link = svg.append("g")
								.attr("class", "links")
								.selectAll("line")
								.data(links)
								.enter().append("line")
								.attr("stroke-width", 2)
								.attr("stroke","black");
	var node = svg.append("g")
								.selectAll("a").data(topics)
								.enter()
								.append("a")
								.attr("xlink:href", function(d) { return "http://"+window.location.host+"/topics/"+d.base+"?center="+d.center+"&from="+d.from+"&page_num="+d.page })
								.attr("class", "nodes")
								.append("circle")
								.attr("r", topic_radius)
								.attr("fill", function(d,i) { return color(i); })
								.attr('stroke','white')
								.attr('stroke-width',2)
								.call(d3.drag()
								.on("start", dragstarted)
								.on("drag", dragged)
								.on("end", dragended));
	var text = svg.selectAll("text")
								.data(topics)
								.enter()
								.append("text")
								.style("fill", "black")
								.attr("dx", 12)
								.attr("dy", 5)
								.text(function(d){return d.name;});
		
	simulation
		.nodes(topics)
		.on("tick", ticked);

	simulation.force("link")
	  .links(links)
		.distance(link_distance);

	simulation.force("charge").strength(charge);

	function ticked() {
		link
			.attr("x1", function(d) { return Math.max(20, Math.min(width -50, d.source.x)); })
			.attr("y1", function(d) { return Math.max(20, Math.min(height-20, d.source.y)); })
			.attr("x2", function(d) { return Math.max(20, Math.min(width -50, d.target.x)); })
			.attr("y2", function(d) { return Math.max(20, Math.min(height-20, d.target.y)); });
		node
			.attr("cx", function(d) { return Math.max(20, Math.min(width -50, d.x)); })
			.attr("cy", function(d) { return Math.max(20, Math.min(height-20, d.y)); });
		text
			.attr("x", function(d) { return Math.max(20, Math.min(width -50, d.x));})
			.attr("y", function(d) { return Math.max(20, Math.min(height-20, d.y));});
	};

	function zoomed() {
		svg.attr('transform', 'scale(' + d3.event.transform.k + ')');
	}

	function dragstarted(d) {
		if (!d3.event.active) simulation.alphaTarget(0.3).restart();
			d.fx = d.x;
			d.fy = d.y;
	};

	function dragged(d) {
		d.fx = d3.event.x;
		d.fy = d3.event.y;
	};

	function dragended(d) {
		if (!d3.event.active) simulation.alphaTarget(0);
		d.fx = null;
		d.fy = null;
	};

	function topic_radius(d) {
		if(d.strength > 2048) return 40;
		if(d.strength > 1024) return 35;
		if(d.strength >  512) return 30;
		if(d.strength >  256) return 25;
		if(d.strength >  128) return 20;
		if(d.strength >   64) return 15;
		if(d.strength >   32) return 10;
		if(d.strength >   16) return  5;
		if(d.strength >    8) return  1;
	};

	function link_distance(d) {
		if(d.strength > 2048) return  30*3;
		if(d.strength > 1024) return  40*3;
		if(d.strength >  512) return  50*3;
		if(d.strength >  256) return  60*3;
		if(d.strength >  128) return  70*3;
		if(d.strength >   64) return  80*3;
		if(d.strength >   32) return  90*3;
		if(d.strength >   16) return 100*3;
		if(d.strength >    8) return 110*3;
		if(d.strength >    0) return 120*3;
		else                  return (d.strength)*-1;
	};
}