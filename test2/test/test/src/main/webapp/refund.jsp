<!DOCTYPE html>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>
<title>Refund</title>
<body>
<div id="demendeInfo">demande details Information:</div>
<script type="text/javascript">
var url=window.location.search;
url=url.substr(1);
url=window.atob(url);
var size=url.split(/[=,&]/).length;
var demandeId=url.split(/[=,&]/)[1];
var bookId=url.split(/[=,&]/)[3];
$('#demendeInfo').append('<ul id="demandeUl"><li id="demandeId">demandeId: '+demandeId+'</li><li id="bookId">bookId: '+bookId+'</li></ul>');
$.ajax({
	url:"/test/delivery/demandeDelivery.do",
	data:{demandeId:demandeId,bookId:bookId},
	type:'POST',
	async:true,
	dataType:'json',
	success:function(result){
		if(result['status1']==0)
		{
			$('#demendeInfo').append(result['errorMsg']);
		}
		else
		{
			if(result['status2']==0)
			{
				$('#demendeInfo').append(result['errorMsg']);
			}
			else
			{
				$('#demandeUl').append('<li>quantity: '+result['demande'].quantity+'</li>');
				$('#demandeUl').append('<li>price: '+result['demande'].totalPrice+'</li>');
				var date=new Date();
				date.setTime(result['demande'].createDate);
				$('#demandeUl').append('<li>demande createDate: '+date.toString()+'</li>');
				if(result['refund']==1)
				{
					$("#refundText").show();
				}
			}
		}
	}
});
</script>
<br/>
<br/>


<div id="refundText" style="display:none;">refund reason:<br/>
<textarea rows="10" cols="100" id="reason">reasons...</textarea> <button onclick="insertRefund()">submit</button>
<p id="response"></p>
</div>
<script type="text/javascript">
function insertRefund()
{
	var demandeId=document.getElementById("demandeId").innerHTML;
	var bookId=document.getElementById("bookId").innerHTML;
	var reason=document.getElementById("reason").value;
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
					url:"http://localhost:8080/test/refund/addRefund.do",
					type:'POST',
					data:{demandeId:demandeId,userId:id,bookId:bookId,refundReason:reason},
					async:true, 
					dape:'json',
					success:function(result){
						document.getElementById("response").innerHTML=result;
					}
				});
			}
		}
	});
}
</script>



</body>
</html>