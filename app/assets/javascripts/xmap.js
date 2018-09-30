function xmap(topics, links, max_layer) {
	//----------------------------------------
	// Size setting
	var width        = $(window).width()*0.9;//
	var height       = $(window).height()*0.8;
	var layer_width  =  width / (max_layer+1) / 2; // 中心 X size
	var layer_height = height / (max_layer+1) / 2;

	//----------------------------------------
	// Style setting
	var base_r       = width/80; //旁支圓半徑，中心現為旁支2倍
	var branch_color = "blue";   //旁支顏色
	var center_color = "orange"; //中心顏色
	var from_color   = "red";    //上一步顏色
	var text_color   = "blue";   //文字顏色
	var line_width   = 2;        //連結線粗細
		
	//----------------------------------------
	// Force setting
	var charge        = -20;      //點與點之間的吸引力（正值相吸、負值相斥）
	var collide       = base_r*4; //以圓心開始，設定半徑數值為『不得重疊』區域
	var link_distance	= base_r*2; //最小連線長度（計算後能符合就會符合）

	/*================================================================================*/
	var simulation = d3.forceSimulation()
										 .force("link", d3.forceLink().strength(1))
										 .force("collide", d3.forceCollide( collide ))
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
								.attr("fill", function(d) { return (d.type === "center") ? center_color : (d.type === "from") ? from_color :  (d.group == 2) ? "green" : branch_color; })
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
		.force('x', d3.forceX().x(forcegroupX(topics)))
		.force('y', d3.forceY().y(forcegroupY(topics)))
		.force("collide", d3.forceCollide( function(d) { return collide;} ) )
		.on("tick", ticked);


	simulation.force("link")
	  .links(links)
			.distance(function(d) {return link_distance;});

	simulation.force("charge").strength(charge);

function forcegroupX(d) {
	return	(d.group === 0) ?  width/2 : 
					(d.group === 1) ?  width/2 + ( layer_width*1.5) : 
					(d.group === 2) ?  width/2 - ( layer_width*1.5) : 
					(d.group === 3) ?  width/2 + ( layer_width*1.5) : 
					(d.group === 4) ?  width/2 - ( layer_width*1.5) : width/2;
}
function forcegroupY(d) {
	return	(d.group === 0) ?  height/2 : 
					(d.group === 1) ?  height/2 - (layer_height*1.5) : 
					(d.group === 2) ?  height/2 - (layer_height*1.5) : 
					(d.group === 3) ?  height/2 + (layer_height*1.5) : 
					(d.group === 4) ?  height/2 + (layer_height*1.5) : height/2;
}

function ticked() {
	link
		.attr("x1", function(d) { return	(d.from_order == 0) ?  width/2 : 
																			(d.from_order == 1) ?  width/2 + ( layer_width*1.5) : 
																			(d.from_order == 2) ?  width/2 - ( layer_width*1.5) : 
																			(d.from_order == 3) ?  width/2 + ( layer_width*1.5) : 
																			(d.from_order == 4) ?  width/2 - ( layer_width*1.5) : 
																														Math.max(20, Math.min(width -(base_r*2), d.source.x)); })																														 
		.attr("y1", function(d) { return	(d.from_order == 0) ? height/2 : 
																			(d.from_order == 1) ? height/2 - (layer_height*1.5) : 
																			(d.from_order == 2) ? height/2 - (layer_height*1.5) : 
																			(d.from_order == 3) ? height/2 + (layer_height*1.5) : 
																			(d.from_order == 4) ? height/2 + (layer_height*1.5) : 
																														Math.max(20, Math.min(height-(base_r*2), d.source.y)); })
		.attr("x2", function(d) { return	(  d.to_order == 0) ?  width/2 : 
																	  	(  d.to_order == 1) ?  width/2 + ( layer_width*1.5) : 
																	  	(  d.to_order == 2) ?  width/2 - ( layer_width*1.5) : 
																	  	(  d.to_order == 3) ?  width/2 + ( layer_width*1.5) : 
																	  	(  d.to_order == 4) ?  width/2 - ( layer_width*1.5) : 
												  																	Math.max(20, Math.min(width -(base_r*2), d.target.x)); })
		.attr("y2", function(d) { return	(  d.to_order == 0) ? height/2 : 
																			(  d.to_order == 1) ? height/2 - (layer_height*1.5) : 
																			(  d.to_order == 2) ? height/2 - (layer_height*1.5) : 
																			(  d.to_order == 3) ? height/2 + (layer_height*1.5) : 
																			(  d.to_order == 4) ? height/2 + (layer_height*1.5) : 
																														Math.max(20, Math.min(height-(base_r*2), d.target.y)); });
	//.attr("x1", function(d) { return (d.layer  == 0) ?  width/2 : Math.max(20, Math.min(width -(base_r*2), d.source.x)); })
	//.attr("y1", function(d) { return (d.layer  == 0) ? height/2 : Math.max(20, Math.min(height-(base_r*2), d.source.y)); })
	//.attr("x2", function(d) { return (d.target == 0) ?  width/2 : Math.max(20, Math.min(width -(base_r*2), d.target.x)); })
	//.attr("y2", function(d) { return (d.target == 0) ? height/2 : Math.max(20, Math.min(height-(base_r*2), d.target.y)); });
	node
		.attr("cx", function(d) { return (d.order == 0) ?  width/2 : 
																		 (d.order == 1) ?  width/2 + ( layer_width*1.5) : 
																		 (d.order == 2) ?  width/2 - ( layer_width*1.5) : 
																		 (d.order == 3) ?  width/2 + ( layer_width*1.5) : 
																		 (d.order == 4) ?  width/2 - ( layer_width*1.5) : 
																		 									 Math.max(20, Math.min(width -(base_r*2), d.x)); })
		.attr("cy", function(d) { return (d.order == 0) ? height/2 : 
																	   (d.order == 1) ? height/2 - (layer_height*1.5) : 
																	   (d.order == 2) ? height/2 - (layer_height*1.5) : 
																	   (d.order == 3) ? height/2 + (layer_height*1.5) : 
																	   (d.order == 4) ? height/2 + (layer_height*1.5) : 
																											 Math.max(20, Math.min(height-(base_r*2), d.y)); });
	//.attr("cx", function(d) { return (d.type === "center") ?  width/2 : Math.max(20, Math.min(width -(base_r*2), d.x)); })
	//.attr("cy", function(d) { return (d.type === "center") ? height/2 : Math.max(20, Math.min(height-(base_r*2), d.y)); });																											 
	text
		.attr("x",  function(d) { return (d.order == 0) ?  width/2 : 
							 											 (d.order == 1) ?  width/2 + ( layer_width*1.5) : 
							 											 (d.order == 2) ?  width/2 - ( layer_width*1.5) : 
							 											 (d.order == 3) ?  width/2 + ( layer_width*1.5) : 
							 											 (d.order == 4) ?  width/2 - ( layer_width*1.5) : 
							 											 									Math.max(20, Math.min(width -(base_r*2), d.x));})
		.attr("y",  function(d) { return (d.order == 0) ? height/2 : 
							 											 (d.order == 1) ? height/2 - (layer_height*1.5) : 
							 											 (d.order == 2) ? height/2 - (layer_height*1.5) : 
							 											 (d.order == 3) ? height/2 + (layer_height*1.5) : 
							 											 (d.order == 4) ? height/2 + (layer_height*1.5) : 
																											 Math.max(20, Math.min(height-(base_r*2), d.y));});
	//.attr("x", function(d) { return (d.type === "center") ?  width/2 : Math.max(20, Math.min(width -(base_r*2), d.x));})
	//.attr("y", function(d) { return (d.type === "center") ? height/2 : Math.max(20, Math.min(height-(base_r*2), d.y));});																											 
};

// Drag and stop
function dragstarted(d, i) {
	d.fixed = false;
};
function dragged(d, i) {
	d.px += d3.event.dx;
	d.py += d3.event.dy;
	d.x += d3.event.dx;
	d.y += d3.event.dy; 
	ticked(); // this is the key to make it work together with updating both px,py,x,y on d !
}
function dragended(d) {
	d.fixed = true; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
};
/*
// Drag and restart
function dragstarted(d, i) {
  d.fixed = false;
//simulation.stop();
};
function dragged(d, i) {
	d.fx = d3.event.x;
	d.fy = d3.event.y;
//d.px += d3.event.dx;
//d.py += d3.event.dy;
//d.x += d3.event.dx;
//d.y += d3.event.dy; 
//ticked(); // this is the key to make it work together with updating both px,py,x,y on d !
}
function dragended(d) {
	d.fixed = true; // of course set the node to fixed so the force doesn't include the node in its auto positioning stuff
  simulation.alphaTarget(0.2).restart();
};
*/
}