<!DOCTYPE html>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>
<title>RefundInfo</title>

<body>
<h1 style="text-align:center;">refund information</h1>
<p>user:</p>
<div id="userInfo">
	<div id="table1-1" style="width:500px; height:100px; float:left;margin:0 auto;"></div>
	<div id="table1-2" style="overflow-x:scroll;margin-left:10px; width:500px; height:200px; float:left;margin: 0 auto;"></div>
</div>

<style>
th{
width:200px;  
border-bottom:1px solid #999;
border-right:1px solid #999;
padding:10px 30px;
height:30px;
}

td{ 
width:200px; 
height:30px; 
border-bottom:1px solid #999;
border-right:1px solid #999;
padding:10px 30px;
overflow:hidden;
text-overflow:ellipsis;
white-space:nowrap;
}

table{
border-top:1px solid #999;
border-left:1px solid #999;
border-spacing:0;
}
</style>

<script type="text/javascript">
var table_1=$('<table>');
table_1.appendTo($("#table1-1"));
var row1=$('<tr></tr>');
row1.append('<th  id="range2">range</th>');
row1.append('<th  id="demandeId1">demandeId</th>');
row1.append('<th  id="userId1">userId</th>');
row1.append('<th  id="bookId1">bookId</th>');
row1.appendTo(table_1);
$("#table1-1").append("<tbody>");

var table2=$('<table>');
table2.appendTo($("#table1-2"));
var row2=$('<tr></tr>');
row2.append('<th  id="quantity1">quantity</th>');
row2.append('<th  id="totalPrice1">totalPrice</th>');
row2.append('<th  id="createDate1">createDate</th>');
row2.append('<th  id="refundDate1">refundDate</th>');
row2.append('<th  id="refundReason1">refundReason</th>');
row2.append('<th  id="acceptOrNot1">acceptOrNot</th>');
row2.append('<th  id="resolveOrNot1">resolveOrNot</th>');
row2.appendTo(table2);
$("#table1-2").append("<tbody>");


$.ajax({
	url:"http://localhost:8080/test/user/verifySession.do",
	type:'GET',
	async:true,
	dataType:'json',
	success:function(result){
		if(result['status']=="0")
			{
			alert(result['errorMsg'])
			}
		else
		{
			var id=result['userId'];
			$.ajax({
				url:"http://localhost:8080/test/refund/listRefund_user.do",
				type:'POST',
				data:{userId:id},
				async:true,
				dataType:'json',
				success:function(result){
					if(result['status']==1)
					{
						$(result['refund']).each(function (i){
							var demandeId= result['refund'][i].demandeId;	
							var bookId=result['refund'][i].bookId;	
							var userId=result['refund'][i].userId;
							var row=$('<tr></tr>');
							row.append('<td >'+(i+1)+'</td>');
							row.append('<td >'+demandeId+'</td>');
							row.append('<td >'+userId+'</td>');
							row.append('<td >'+bookId+'</td>');
						    row.appendTo(table_1);
							var quantity=result['demande'][i].quantity;
							var price=result['demande'][i].totalPrice;
							var e=result['demande'][i].createDate;
							var time=new Date(e).toLocaleString().substring(0, 9);
							var f=result['refund'][i].beginDate;
							var time2=new Date(f).toLocaleString().substring(0, 9);
							var reason=result['refund'][i].refundReason;
							var row=$('<tr id="+i+"></tr>');
							row.append('<td>'+quantity+'</td>');
							row.append('<td>'+price+'</td>');
							row.append('<td>'+time+'</td>');
							row.append('<td>'+time2+'</td>');
							row.append('<td>'+reason+'</td>');
							if(result['refund'][i].acceptRefund==0)
							{
								row.append('<td>待处理</td>');
								row.append('<td>待处理</td>');
							}
							else 
							{
								if(result['refund'][i].acceptRefund==1)
								{
									row.append('<td>已被接受</td>');
									row.append('<td><button onclick="moneyReceive('+demandeId+','+bookId+')">submit</button></td>');
								}
								else (result['refund'][i].acceptRefund==2)
								{
									row.append('<td>已被拒绝</td>');
									row.append('<td><button onclick="moneyReceive('+demandeId+','+bookId+')">submit</button></td>');
								}
							}
						    row.appendTo(table2);
						});
						$("#table1-1").append("</tbody>");
						$("#table1-1").append("</table>");
						$("#table1-2").append("</tbody>");
						$("#table1-2").append("</table>");
					}
				}
			});
		}
	}
});
</script>



<div id="sellerInfo" style="position:absolute;top: 500px;">
	<p>seller:</p>
	<div id="table2-1" style="width:500px; height:100px; float:left;margin: 0 auto;"></div>
	<div id="table2-2" style="overflow-x:scroll; margin-left:10px; width:500px; height:200px; float:left;margin: 0 auto;"></div>
</div>
<script type="text/javascript">
var table_3=$('<table>');
table_3.appendTo($("#table2-1"));
var row3=$('<tr></tr>');
row3.append('<th  id="range2">range</th>');
row3.append('<th  id="demandeId2">demandeId</th>');
row3.append('<th  id="userId2">userId</th>');
row3.append('<th  id="bookId2">bookId</th>');
row3.appendTo(table_3);
$("#table2-1").append("<tbody>");
$("#table2-1").append("</tbody>");
$("#table2-1").append("</table>");

var table4=$('<table>');
table4.appendTo($("#table2-2"));
var row4=$('<tr></tr>');
row4.append('<th  id="quantity2">quantity</th>');
row4.append('<th  id="totalPrice2">totalPrice</th>');
row4.append('<th  id="createDate2">createDate</th>');
row4.append('<th  id="refundDate2">refundDate</th>');
row4.append('<th  id="refundReason2">refundReason</th>');
row4.append('<th  id="acceptOrNot2">acceptOrNot</th>');
row4.append('<th  id="resolveOrNot2">resolveOrNot</th>');
row4.appendTo(table4);
$("#table2-2").append("<tbody>");
$("#table2-2").append("</tbody>");
$("#table2-2").append("</table>");

$.ajax({
	url:"http://localhost:8080/test/user/verifySession.do",
	type:'GET',
	async:true,
	dataType:'json',
	success:function(result){
		if(result['status']=="0")
			{
			alert(result['errorMsg'])
			}
		else
		{
			var id=result['userId'];
			$.ajax({
				url:"http://localhost:8080/test/refund/listRefund_seller.do",
				type:'POST',
				data:{sellerId:id},
				async:true,
				dataType:'json',
				success:function(result){
					if(result['status']==1)
					{
						$(result['refund']).each(function (i){
							var demandeId= result['refund'][i].demandeId;	
							var bookId=result['refund'][i].bookId;	
							var userId=result['refund'][i].userId;
							var row=$('<tr></tr>');
							row.append('<td>'+(i+1)+'</td>');
							row.append('<td>'+demandeId+'</td>');
							row.append('<td>'+userId+'</td>');
							row.append('<td>'+bookId+'</td>');
						    row.appendTo(table_3);
							var quantity=result['demande'][i].quantity;
							var price=result['demande'][i].totalPrice;
							var e=result['demande'][i].createDate;
							var time=new Date(e).toLocaleString().substring(0, 9);
							var f=result['refund'][i].beginDate;
							var time2=new Date(f).toLocaleString().substring(0, 9);
							var reason=result['refund'][i].refundReason;
							var row=$('<tr></tr>');
							row.append('<td>'+quantity+'</td>');
							row.append('<td>'+price+'</td>');
							row.append('<td>'+time+'</td>');
							row.append('<td>'+time2+'</td>');
							row.append('<td>'+reason+'</td>');
							if(result['refund'][i].acceptRefund==0)
							{
								row.append('<td><button onclick="acceptRefund('+demandeId+','+bookId+',1)">accept</button>&nbsp<button onclick="acceptRefund('+demandeId+','+bookId+',2)">refuse</button></td>');
								row.append('<td>未解决</td>');
							}
							else 
							{
								if(result['refund'][i].acceptRefund==1)
								{
									row.append('<td>已接受</td>');
									row.append('<td>进行中</td>');
								}
								else (result['refund'][i].acceptRefund==2)
								{
									row.append('<td>已拒绝</td>');	
									row.append('<td>进行中</td>');
								}
							}
						    row.appendTo(table4);
						});
						$("#table2-1").append("</tbody>");
						$("#table2-1").append("</table>");
						$("#table2-2").append("</tbody>");
						$("#table2-2").append("</table>");
					}
				}
			});
		}
	}
});
</script>
<script type="text/javascript">
function acceptRefund(demandeId,bookId,accept){
	$.ajax({
		url:"http://localhost:8080/test/refund/acceptRefund.do",
		type:'POST',
		data:{demandeId:demandeId,bookId:bookId,accept:accept},
		async:true,
		dataType:'json',
		success:function(result){
			alert(result);
		}
	});
	}
	
	function moneyReceive(demandeId,bookId){
		$.ajax({
			url:"http://localhost:8080/test/refund/resolveOrNot.do",
			type:'POST',
			data:{demandeId:demandeId,bookId:bookId},
			async:true,
			dataType:'json',
			success:function(result){
				alert(result);
			}
		});
	}
</script>

</body>
</html>