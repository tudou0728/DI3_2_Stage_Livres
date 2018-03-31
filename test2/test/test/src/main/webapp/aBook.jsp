<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>
<head>
<title>book information</title>
</head>
<body>
<h1>a book welcome!</h1>
<div id="bookInformation">book information:</div>
<script type="text/javascript">
var bookId=window.location.href.split("=")[1];
//alert(bookId);
$.ajax({
	url:"/test/book/selectBook.do",
	type:"POST",
	data:{bookId:bookId},
	dataType:'json',
	async:true,
	success:function(result){
		if(result['status']=='0')
		{
			alert(result['errorMsg']);
		}
		else
		{
			var t=result['data'];
			var sellerId=result['data'].bookSellerId;
			var bookId=result['data'].bookId;
			var bookName=result['data'].bookName;
			var quantity=result['data'].bookQuantity;
			var price=result['data'].bookUnitPrice;
			var sale=result['data'].sale;
			$.ajax({
				url:"/test/user/getUserName.do",
				type:"POST",
				data:{userId:sellerId},
				dataType:'json',
				async:true,
				success:function(result){
					var sellerName=result;
					var table=$('<ul></ul>');
					table.appendTo($("#bookInformation"));				
					table.append('<li>sellerName: '+sellerName+'</li>');
					table.append('<li id="bookId">bookId: '+bookId+'</li>');
					table.append('<li id="bookName">bookName: '+bookName+'</li>');
					table.append('<li id="quantity">bookQuantity: '+quantity+'</li>');
					table.append('<li id="price">bookUnitPrice: '+price+'</li>');
					table.append('<li>bookSale: '+sale+'</li>');
				},
				error:function(){
					alert("wrong");
				}
			});
		}
	},
	error:function(){
		alert("find book failed.");
	}
});
</script>
<br/>
<br/>

<p>buy quantity:
<input id="buyQuantity" type="text">  <button onclick="shoppingTrolley()">shopping trolley</button> <button onclick="buyBook()">buy</button>
</p>
<p id="response"></p>
<script type="text/javascript">

function shoppingTrolley()
{
	$.ajax({
		url:"http://localhost:8080/test/user/verifySession.do",
		type:'GET',
		async:true,
		dataType:'json',
		success:function(result){
			
				if(result['status']=="0")
				{
					alert(result['errorMsg']);
				}
				else
				{
					var userId=result['userId'];
					var demandeId;
					$.ajax({
						url: "/test/demande/getRandomDemandeId.do",
						type:'GET',
						async:true,
						dataType:'json',
						success:function(result){
							 demandeId=JSON.stringify(result);
							 var quantity=document.getElementById("buyQuantity").value;
							 if(quantity!=null)
							{
							 var bookId=document.getElementById("bookId").innerHTML;
							 $.ajax({
									url: "/test/demande/insertDemande.do",
									type:'POST',
									async:true,
									dataType:'json',
									data:{bookId:bookId,quantity:quantity,demandeId:demandeId,userId:userId},
									success:function(result2){
										alert(result2);
										document.getElementById("response").innerHTML=result2;
										
									}
							 });
							}
							 else
							{
								 alert("please input quantity");
							}
							},
						error:function(){
							alert('error1.');
						}
					});
					
				}
			}
		});	
}
function buyBook()
{
	$.ajax({
		url:"http://localhost:8080/test/user/verifySession.do",
		type:'GET',
		async:true,
		dataType:'json',
		success:function(result){
			
				if(result['status']=="0")
				{
					alert(result['errorMsg']);
				}
				else
				{
					var userId=result['userId'];
					var demandeId;
					$.ajax({
						url: "/test/demande/getRandomDemandeId.do",
						type:'GET',
						async:true,
						dataType:'json',
						success:function(result){
							 demandeId=JSON.stringify(result);
							 var quantity=document.getElementById("buyQuantity").value;
							 if(quantity!=null)
							{
							 var bookId=document.getElementById("bookId").innerHTML;
							 $.ajax({
									url: "/test/demande/insertDemande.do",
									type:'POST',
									async:true,
									dataType:'json',
									data:{bookId:bookId,quantity:quantity,demandeId:demandeId,userId:userId},
									success:function(result2){
										alert(result2);
										document.getElementById("response").innerHTML=result2;
										var s=result2.indexOf("demande");
										if(result2.indexOf("demande")>0)
										{
											var dId=demandeId.replace("\"", "");
											dId=dId.replace("\"", "");
											var bId=bookId.split(":")[1].trim();
											var price=document.getElementById("price").innerHTML.split(":")[1].trim();
											var url="/test/demande/toDeliverPay.do?demandeId="+dId+"&bookId="+bId+"&unitprice="+price;
											window.open(url);
										}
									}
							 });
							}
							 else
								 {
								 	alert("please enter quantity");
								 }
							},
						error:function(){
							alert('error1.');
						}
					});
					
				}
			}
		});
}
</script>
<br/>
<br/>

<div id="bookComments" class="tableComment">comments:</div>
<script type="text/javascript">
var bookId=window.location.href.split("=")[1];
$.ajax({
	url:"/test/comment/listComment.do",
	type:"POST",
	data:{bookId:bookId},
	dataType:'json',
	async:true,
	success:function(result){
		if(result['status']==0)
		{
			$('#bookComments').append(result['errorMsg']);
		}
		else
		{
			var table=$('<table style="border-top:1px solid #999;border-left:1px solid #999;border-spacing:0;">');	
			var row1=$('<tr></tr>');
			row1.append('<th width=50" style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">range</th>');
			row1.append('<th width=500" style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">comment</th>');
			row1.appendTo(table);
			$('#bookComments').append(table);
			$(result['data']).each(function(i){
				var t=result['data'][i].bookComment;
				var row=$('<tr></tr>');
				var s=result['data'][i].commentNo;
				row.append('<td style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;">'+(i+1)+'</td>');
				row.append('<td style="border-bottom:1px solid #999;border-right:1px solid #999;padding:10px 30px;" >'+result['data'][i].bookComment+'</td>');
				row.appendTo(table);
			});
			
			$("#bookComments").append("</table>");
		}
	}
});
</script>



</body>
</html>