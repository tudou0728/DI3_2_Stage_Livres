<!DOCTYPE html>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>

<body>
<h1 style="text-align:center">Information! </h1>
<p>1、new delivery information</p>
<button onclick="deleteInfo()">check</button>
<p id="table_deliveryCal"></p>
<p id="response_deliveryCal"></p>
<script type="text/javascript">
function deleteInfo()
{
$.ajax({
	url:"http://localhost:8080/test/user/verifySession.do",
	type:'GET',
	async:true,
	dataType:'json',
	success:function(result)
		{
			if(result['status']=="0")
			{
				alert(result['errorMsg'])
			}
			else
			{
				var userId=result['userId'];
				var rowNumber;
				document.getElementById("table_deliveryCal").innerHTML="";
				var table=$('<table id="table1" border="1">');
				table.appendTo($("#table_deliveryCal"));
				var row1=$('<tr></tr>');
				row1.append('<th width="200">range</th>');
				row1.append('<th width="200">userId</th>');
				row1.append('<th width="200">sellerId</th>');
				row1.append('<th width="200">deliveryId</th>');
				row1.append('<th width="200">bookId</th>');
				row1.appendTo(table);
				$.ajax
				({
					url: "/test/delivery/infoDeliveryCal.do",
						type:'POST',
						data:{userId:userId},
						async:false,
						dataType:'json',
						success:function(result){
							if(result['status']=="0")
							{
								alert(result['errorMsg']);
								document.getElementById("response_deliveryCal").innerHTML="0  records";
								document.getElementById("table_deliveryCal").innerHTML="";
							}
							else
							{
								$(result['data']).each(function (i){
									 var uId= result['data'][i].userId;	
									 var sellerId=result['data'][i].sellerId;	
									 var deliveryId=result['data'][i].deliveryId;
									 var bookId=result['data'][i].bookId;
									 var row=$('<tr></tr>');
									 row.append('<td>'+(i+1)+'</td>');
									 row.append('<td>'+uId+'</td>');
									 row.append('<td>'+sellerId+'</td>');
									 row.append('<td>'+deliveryId+'</td>');
									 row.append('<td>'+bookId+'</td>');
									 row.appendTo(table);
									 rowNumber=i+1;
								 }); 
								  $("#table_deliveryCal").append("</table>");
								  document.getElementById("response_deliveryCal").innerHTML=rowNumber+" records";
							}
						}
				});
				$.ajax
				({
					url: "/test/delivery/deleteInfo.do",
						type:'GET',
						data:{userId:userId},
						async:false,
						dataType:'json',
						success:function(result){
							if(result==true)
							{
								alert(rowNumber+" records");
							}
							else
							{
								alert("not any new informations");
							}
						},
				});
			}
		},
	error:function(){
		alert("please log in again");
	}
});
}
</script>
<br/>
<br/>

<p>2、new demande information</p>
<button onclick="deleteDeliveryCalInfo()">check</button>
<p id="table_demandeCal"></p>
<p id="response_demandeCal"></p>
<script type="text/javascript">
function deleteDeliveryCalInfo()
{
$.ajax({
	url:"http://localhost:8080/test/user/verifySession.do",
	type:'GET',
	async:true,
	dataType:'json',
	success:function(result)
		{
			if(result['status']=="0")
			{
				alert(result['errorMsg'])
			}
			else
			{
				var userId=result['userId'];
				var rowNumber;
				document.getElementById("table_demandeCal").innerHTML="";
				var table=$('<table id="table1" border="1">');
				table.appendTo($("#table_demandeCal"));
				var row1=$('<tr></tr>');
				row1.append('<th width="200">range</th>');
				row1.append('<th width="200">sellerId</th>');
				row1.append('<th width="200">userId</th>');				
				row1.append('<th width="200">demandeId</th>');
				row1.append('<th width="200">bookId</th>');
				row1.appendTo(table);
				$.ajax
				({
					url: "/test/demande/infoDemandeCal.do",
						type:'POST',
						data:{sellerId:userId},
						async:false,
						dataType:'json',
						success:function(result){
							if(result['status']=="0")
							{
								alert(result['errorMsg']);
								document.getElementById("response_demandeCal").innerHTML="0  records";
								document.getElementById("table_demandeCal").innerHTML="";
							}
							else
							{
								$(result['data']).each(function (i){
									 var uId= result['data'][i].userId;	
									 var sellerId=result['data'][i].sellerId;	
									 var demandeId=result['data'][i].demandeId;
									 var bookId=result['data'][i].bookId;
									 var row=$('<tr></tr>');
									 row.append('<td>'+(i+1)+'</td>');
									 row.append('<td>'+sellerId+'</td>');
									 row.append('<td>'+uId+'</td>');
									 row.append('<td>'+demandeId+'</td>');
									 row.append('<td>'+bookId+'</td>');
									 row.appendTo(table);
									 rowNumber=i+1;
								 }); 
								  $("#table_demandeCal").append("</table>");
								  document.getElementById("response_demandeCal").innerHTML=rowNumber+" records";
							}
						}
				});
				$.ajax
				({
					url: "/test/demande/deleteInfo.do",
						type:'POST',
						data:{sellerId:userId},
						async:false,
						dataType:'json',
						success:function(result){
							if(result==true)
							{
								alert(rowNumber+" records");
							}
							else
							{
								alert("not any new informations");
							}
						},
				});
			}
		},
	error:function(){
		alert("please log in again");
	}
});
}
</script>


</body>
</html>