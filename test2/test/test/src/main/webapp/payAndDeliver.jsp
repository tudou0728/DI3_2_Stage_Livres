<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>
<title>deliver and pay</title>
<body>
<div id="demendeInfo">1-demande information:</div>
<script type="text/javascript">
var url=window.location.href;
var size=url.split(/[=,&]/).length;
if(size<=6)
{
var demandeId=url.split(/[=,&]/)[1];
var bookId=url.split(/[=,&]/)[3];
var unitP=url.split(/[=,&]/)[5];
$('#demendeInfo').append('<ul id="demandeUl"><li id="demandeId">demandeId: '+demandeId+'</li><li id="bookId">bookId: '+bookId+'</li></ul>');
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
				$('#demandeUl').append('<li>userId: '+userId+'</li>');
				$('#demandeUl').append('<li>unitPrice: '+unitP+'</li>');
				$.ajax({
					url:"http://localhost:8080/test/demande/demande.do",
					type:'POST',
					async:true,
					dataType:'json',
					data:{demandeId:demandeId,bookId:bookId},
					success:function(result){
						if(result['status']==0)
						{
							alert(result['errorMsg']);
							$('#demendeInfo').append(result['errorMsg']);
						}
						else
						{
							var price=result['data'].totalPrice;
							var quantity=result['data'].quantity;	
							
							$('#demandeUl').append('<li>quantity: '+quantity+'</li>');
							$('#demandeUl').append('<li>price: '+price+'</li>');
						}
					}
				});
			}
	}
});
}
else
{
	//alert(url);
	if(size==7)
	{
		var demandeId=url.split(/[=,&]/)[2];
		var bookId=url.split(/[=,&]/)[4];
		var totalPrice=url.split(/[=,&]/)[6];
		
		$('#demendeInfo').append('<ul id="demandeUl"><li id="demandeId">demandeId: '+demandeId+'</li><li id="bookId">bookId: '+bookId+'</li><li id="price">price: '+totalPrice+'</li></ul>');
	}
	else
	{
		var list=new Array();
		var tPrice=0;
		for(var i=2;i+2<size;i=i+6)
		{
			var demandeId=url.split(/[=,&]/)[i];
			var bookId=url.split(/[=,&]/)[i+2];
			var totalPrice=url.split(/[=,&]/)[i+4];
			tPrice=tPrice+parseFloat(totalPrice);
			list.push({"demandeId":demandeId,"bookId":bookId,"price":totalPrice});
		}
	
		var t=list[1].demandeId;	
		$(list).each(function(j){
			$('#demendeInfo').append('<ul id="demandeUl"><li>'+(j+1)+'</li><li id="demandeId">demandeId: '+list[j].demandeId+'</li><li id="bookId">bookId: '+list[j].bookId+'</li><li id="price">price: '+list[j].price+'</li></ul>');	
		});
		$('#demendeInfo').append('<p>totally cost= '+tPrice+' ¥</p>');
		}
}
</script>
<br/>
<br/>


<div id="addAdress">2-adress:
<input id="adress" type="text">  <button onclick="addAdress()">submit</button><br/>
<p id="responseUpdateAdress"></p>
</div>
<script type="text/javascript">
function addAdress(){
	var adress=document.getElementById("adress").value;
	if(size<=6)
	{
	var demandeId=document.getElementById("demandeId").innerHTML.split(":")[1].trim();
	var bookId=document.getElementById("bookId").innerHTML.split(":")[1].trim();
	$.ajax({
		url:"http://localhost:8080/test/demande/updateAdress.do",
		type:'POST',
		async:true,
		dataType:'json',
		data:{demandeId:demandeId,bookId:bookId,adress:adress},
		success:function(result){
			alert(result);
			document.getElementById("responseUpdateAdress").innerHTML=result;
			//$('#addAdress').append('<p>'+result+'</p>');
		}
	});
	}
	else
	{
		$.ajax({
			url:"http://localhost:8080/test/demande/updateAllDeAdress.do",
			type:'POST',
			async:true,
			dataType:'json',
			data:{demande:url,adress:adress},
			success:function(result){
				alert(result);
				document.getElementById("responseUpdateAdress").innerHTML=result;
				//$('#addAdress').append('<p>'+result+'</p>');
			}
		});
	}
}
</script>
<br/>
<br/>

<div id="pay">3-pay: <button onclick="pay()">pay</button></div>
<p id="responsePay"></p>
<script type="text/javascript">
function pay(){
if(size<=7)
{
	var r=confirm("submit");
	if(r==true)
	{
		var demandeId=document.getElementById("demandeId").innerHTML.split(":")[1].trim();
		var bookId=document.getElementById("bookId").innerHTML.split(":")[1].trim();
		$.ajax({
			url:"http://localhost:8080/test/demande/payUpdate.do",
			type:'POST',
			async:true,
			dataType:'json',
			data:{demandeId:demandeId,bookId:bookId},
			success:function(result){
				alert(result);
				document.getElementById("responsePay").innerHTML=result;		
			}
		});
	}
	else
	{
		alert("annuler successfully.");
	}
}
else
{
	//alert(url);
		$.ajax({
			url:"http://localhost:8080/test/demande/allDepayUpdate.do",
			type:'POST',
			async:true,
			dataType:'json',
			data:{demande:url},
			success:function(result){
				alert(result);
				document.getElementById("responsePay").innerHTML=result;
			}
		});
	}
	
}
</script>


</body>
</html>