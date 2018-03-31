<!DOCTYPE html>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>
<title>demande details</title>
</head>
<body>
<h1 style="text-align:center">demande details</h1>
<div id="detailsInformation">demande details Information:</div>
<div id="detailsInformation_delivery">delivery details Information:</div>
<script type="text/javascript">
var param=window.location.search;
param=param.substr(1);
param=window.atob(param);
var demandeId=param.split(/[=,&]/)[1];
var bookId=param.split(/[=,&]/)[3];
$('#detailsInformation').append('<ul><li>demandeId: '+demandeId+'</li><li>bookId: '+bookId+'</li></ul>');
$.ajax({
	url:"/test/delivery/demandeDelivery.do",
	data:{demandeId:demandeId,bookId:bookId},
	async:true,
	dataType:'json',
	success:function(result){
		if(result['status1']==0)
		{
			$('#detailsInformation').append(result['errorMsg']);
		}
		else
		{
			$('#detailsInformation').append('<ul><li>quantity: '+result['demande'].quantity+'</li><li>totalPrice: '+result['demande'].totalPrice+'</li></ul>');
			if(result['status2']==0)
			{
				$('#detailsInformation_delivery').append(result['errorMsg']);
			}
			else
			{
				if(result['delivery'].signOrNot==1)
				{
					$("#hide").hide();
					$("#detailsInformation_delivery").append("deja arrive,deja sign, thanks.");
				}
				else
				{
					$('#detailsInformation_delivery').append('<ul><li id="deiveryId">deliveryId: '+result['delivery'].deliveryId+'</li><li>now arrive at: '+result['delivery'].nowArriveAt+'</li></ul>');
					var t=document.getElementById("signAndComment").style.display;
					document.getElementById("signAndComment").style.display="";
				}
			}
		}
	}
});
	function signAndComment(){
		$.ajax({
			url:"/test/user/verifySession.do",
			type:'GET',
			async:false,
			dataType:'json',
			success:function(result){
				if(result['status']=="0")
					{
					alert(result['errorMsg'])
					}
				else
				{
					var id=result['userId'];
					var t=document.getElementById("deiveryId").innerHTML;
					t=t.split(":")[1];
					url="http://localhost:8080/test/user/inverseArrive.do?"+window.btoa("demandeId="+demandeId+"&bookId="+bookId+"&deliveryId="+t);
					window.open(url);
				}
			}
		})
	}
</script>

<div id="hide"><button id="signAndComment" onclick="signAndComment()" style="display:none">arrive already</button></div>

</body>
</html>