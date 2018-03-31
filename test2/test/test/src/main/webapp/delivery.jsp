<!DOCTYPE html>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>

<body>
<h1 style="text-align:center">DeliveryService</h1>
<style>
	a
	{
		position:absolute;
		top:30px;
		right:50px;
	}
</style>
<a href="http://localhost:8080/test">homepage</a>

<style>
	div
	{
		display:none;
	}
	li
	{
		float:left;
		display:inline;
		width:200px;
		border-top:1px solid #999;
		border-left:1px solid #999;
		border-right:1px solid #999;
	}
	#deliveryInfo
	{
		position:absolute;
		width:1000px;
		left:350px;
		text-align: center;
	}
</style>
<ul id="deliveryInfo" >
	<li value=1>waiting for delivery</li>
	<li value=2>start to deliver</li>
	<li value=3>update delivery info</li>
</ul>
<script type="text/javascript">
var list=document.getElementsByTagName("li");
var list2=document.getElementsByTagName("div");
var style="float:left;display:inline;width:200px;border-top:1px solid #999;border-left:1px solid #999;border-right:1px solid #999;";
var style2="position:absolute;display:none;top:200px;left:120px;width:1000px;text-align:center;";
$("li").click(function(){
	for(var i=0;i<list.length;i++)
	{
		list[i].style=style;
	}
	list2[0].style=style2;
	list2[1].style="position:absolute;display:none;top:200px;left:400px;";
	list2[2].style="position:absolute;display:none;top:200px;left:400px;";
	this.style=style+"background-color:	#FFB5B5;";
	if(this.value==1)
	{
		$("#part1").style="position:absolute;display:none;top:200px;left:100px;";
		$("#part1").show();
	}
	if(this.value==2)
	{
		$("#part2").style=style2;
		$("#part2").show();
	}
	if(this.value==3)
	{
		$("#part3").style=style2;
		$("#part3").show();
	}
});
</script>
<div id="part1" style="left:100px;">
<p>1、demandes waiting for delivery：<button onclick="getDemandeForDeliver()">search</button></p>
	<p id="delivery_demandeForDeliver_table" ></p>
	<p id="response_getDemandeForDeliver"></p></div>
	<script type="text/javascript">
			function getDemandeForDeliver(){
				var num;
				$.ajax({
					url:"http://localhost:8080/test/user/verifySession.do",
					type:'GET',
					async:true,
					dataType:'json',
					success:function(result){
						{
							if(result['status']=="0")
							{
								alert(result['errorMsg']);
								document.getElementById("response_getDemandeForDeliver").innerHTML="0 records";
							}
							else
							{
								var uId=result['userId'];
								document.getElementById("delivery_demandeForDeliver_table").innerHTML="";
								var table=$('<table border="1">');
								table.appendTo($("#delivery_demandeForDeliver_table"));
								var row1=$('<tr></tr>');
								row1.append('<th width=200 id="rangeIdForDeliver">range</th>');
								row1.append('<th width=200 id="demandeIdForDeliver">demandeId</th>');
								row1.append('<th width=200 id="userIdForDeliver">userId</th>');
								
								row1.append('<th width=200 id="bIdForDeliver">bookId</th>');
								row1.append('<th width=200 id="bQuantityForDeliver">quantity</th>');
								row1.append('<th width=200 id="priceForDeliver">cost</th>');
								
								row1.append('<th width=200 id="deliveryAdressForDeliver">adress</th>');
								row1.append('<th width=200 id="demandeDateForDeliver">createTime</th>');
								row1.appendTo(table);				
								$.ajax({
									url:"/test/delivery/searchDemandeToDeliver.do",
									type:'POST',
									data:{userId:uId},
									async:true,
									dataType:'json',
									success:function(result){
										if(result['status'] !="1")
										{
											alert(result['errorMsg']);
										}
										else
										{
										$(result['data']).each(function(i){
											var demandeId=result['data'][i].demandeId;
											var userId=result['data'][i].userId;
											var adress=result['data'][i].deliveryAdress;
											var d=result['data'][i].createDate;
											var bId=result['data'][i].bookId;//
											var bQuantity=result['data'][i].quantity;//
											var price=result['data'][i].totalPrice;//
											var date=new Date(parseInt(d)).toLocaleString().substring(0, 19);			
											//var rowLength=$("demandeForDeliver_table").length;
											var rowId="row";
											var rangeIdForDeliver="rangeIdForDeliver";
											var demandeIdForDeliver="demandeIdForDeliver";
											var userIdForDeliver="userIdForDeliver";
											var deliveryAdressForDeliver="deliveryAdressForDeliver";
											var demandeDateForDeliver="demandeDateForDeliver";
											var bIdForDeliver= "bIdForDeliver";
											var bQuantityForDeliver=" bQuantityForDeliver"; 
											var priceForDeliver="priceForDeliver";

											rowId=rowId+(i+1);
											rangeIdForDeliver=rangeIdForDeliver+(i+1);
											demandeIdForDeliver=demandeIdForDeliver+(i+1);
											userIdForDeliver=userIdForDeliver+(i+1);
											deliveryAdressForDeliver=deliveryAdressForDeliver+(i+1);
											demandeDateForDeliver=demandeDateForDeliver+(i+1);
											bIdForDeliver=bIdForDeliver+(i+1);
											bQuantityForDeliver=bQuantityForDeliver+(i+1);
											priceForDeliver=priceForDeliver+(i+1);
											
											var row=$('<tr id="'+rowId+'"></tr>');
											row.append('<td id="'+rangeIdForDeliver+'">'+(i+1)+'</td>');
											row.append('<td id="'+demandeIdForDeliver+'">'+demandeId+'</td>');
											row.append('<td id="'+userIdForDeliver+'">'+userId+'</td>');
											row.append('<td id="'+bIdForDeliver+'">'+bId+'</td>');
											row.append('<td id="'+bQuantityForDeliver+'">'+bQuantity+'</td>');
											row.append('<td id="'+priceForDeliver+'">'+price+'</td>');
											row.append('<td id="'+deliveryAdressForDeliver+'">'+adress+'</td>');
											row.append('<td id="'+demandeDateForDeliver+'">'+date+'</td>');
											
											row.appendTo(table);
											num=i+1;
										})
										 $("#delivery_demandeForDeliver_table").append("</table>");
										document.getElementById("response_getDemandeForDeliver").innerHTML=num+" records";
										}
									},
									error:function(){
										alert('error.');
									}
								});
							}
						}
					},
					error:function(){
						alert("please try again");
					},
				});
			}
	</script>	
<br/>
<br/>

<div id="part2">
<p>2、startDeliver: <button onclick="startDelivery()">start</button></p>
<p>please input demandeId<input id="demandeIdStartDeliver" type="text"></p>
<p>please input bookId<input id="bookIdDeliver" type="text"></p>
<p>please input deliveryId<input id="deliveryIdDeliver" type="text"></p>
<p id="deliveryId"></p></div>
<script type="text/javascript">
	function startDelivery(){
		$.ajax({
			url:"http://localhost:8080/test/user/verifySession.do",
			type:'GET',
			async:true,
			dataType:'json',
			success:function(result){
				{
					if(result['status']=="0")
					{
						alert(result['errorMsg'])
					}
					else
					{
						var userId=result['userId'];
						var d=document.getElementById("demandeIdStartDeliver").value;
						var bookId=document.getElementById("bookIdDeliver").value;
						var deliveryId=document.getElementById("deliveryIdDeliver").value;
						$.ajax({
							url: "/test/delivery/startToDeliver.do",
							type:'POST',
							async:true,
							data:{demandeId:d,bookId:bookId,deliveryId:deliveryId,userId:userId},
							dataType:'json',
							success:function(result){
								 var response=JSON.stringify(result);
								 //alert(demandeId);
								 document.getElementById("deliveryId").innerHTML=response;
								},
							error:function(){
								alert('error.');
							}
						});
					}
				}
			},
			error:function(){
				alert("please try again");
			},
		});
	}
</script>
<br/>
<br/>

<div id="part3">
<p>3、update delivery information: <button onclick="updateDelivery()">verify</button></p>
<p>please input deliveryId<input id="deliveryIdUpdateDeliver" type="text"></p>
<p>please input adress<input id="deliverAdress" type="text"></p>
<p id="response_updateDelivery"></p></div>
<script type="text/javascript">
function updateDelivery(){
	var deliveryId=document.getElementById("deliveryIdUpdateDeliver").value;
	var adress=document.getElementById("deliverAdress").value;
	$.ajax({
		url:"http://localhost:8080/test/user/verifySession.do",
		type:'GET',
		async:true,
		dataType:'json',
		success:function(result){
			{
				if(result['status']=="0")
				{
					alert(result['errorMsg'])
				}
				else
				{
					var userId=result['userId'];
					$.ajax({
						url:"http://localhost:8080/test/delivery/nowArriveAt.do",
						type:'POST',
						data:{deliveryId:deliveryId,arriveAt:adress,userId:userId},
						async:true,
						dataType:'json',
						success:function(result){
							alert(result);
							var response=JSON.stringify(result);
							document.getElementById("response_updateDelivery").innerHTML=response;
						},
					});
				}
			}
		},
		error:function(){
			alert("please try again");
		},
	});
}
</script>



</body>
</html>