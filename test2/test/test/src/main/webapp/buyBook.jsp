<!DOCTYPE html>
<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>  
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>

<body>
<h1 style="text-align:center">Buy Book! </h1>
<style>
a
{
position:absolute;
top:30px;
right:5px;
}
</style>

<a href="http://localhost:8080/test">homepage</a>

<p>2-2、search books：<input id="searchBookName" type="text">
<button onclick="searchBookName()">search bookName</button></p>
<p id="response_searchBookName"></p>
<p id="table_searchBookName"></p>
<script type="text/javascript">
	function searchBookName(){
	var bookName=document.getElementById("searchBookName").value;
	var name="%"+bookName+"%";
	$.ajax({
		url: "/test/book/searchBookName.do",
			type:'POST',
			async:true,
			data:{bookName:name},
			dataType:'json',
			success:function(result){
				if(result['status']=="0")
				{
					alert(result['errorMsg']);
					document.getElementById("response_searchBookName").innerHTML="0 records";
					document.getElementById("table_searchBookName").innerHTML="";
				}
				else
				{
					var rowLength;
					document.getElementById("table_searchBookName").innerHTML="";
					var table=$('<table border="1">');
					table.appendTo($("#table_searchBookName"));
					var row1=$('<tr></tr>');
					row1.append('<th width=200 id="table_searchBookName_rangeId">range</th>');
					row1.append('<th width=200 id="table_searchBookName_bookId">bookId</th>');
					row1.append('<th width=200 id="table_searchBookName_bookName">bookName</th>');
					row1.append('<th width=200 id="table_searchBookName_bookQuantity">bookQuantity</th>');
					row1.append('<th width=200 id="table_searchBookName_bookUnitPrice">bookUnitPrice</th>');
					row1.appendTo(table);	
					
					$(result['data']).each(function(i){
						var rowId="row";
						var table_searchBookName_rangeId="table_searchBookName_rangeId";
						var table_searchBookName_bookId="table_searchBookName_bookId";
						var table_searchBookName_bookName="table_searchBookName_bookName";
						var table_searchBookName_bookQuantity="table_searchBookName_bookQuantity";
						var table_searchBookName_bookUnitPrice="table_searchBookName_bookUnitPrice";
						
						table_searchBookName_rangeId=table_searchBookName_rangeId+(i+1);
						table_searchBookName_bookId=table_searchBookName_bookId+(i+1);
						table_searchBookName_bookName=table_searchBookName_bookName+(i+1);
						table_searchBookName_bookQuantity=table_searchBookName_bookQuantity+(i+1);
						table_searchBookName_bookUnitPrice=table_searchBookName_bookUnitPrice+(i+1);
						
						var row=$('<tr id="'+rowId+'"></tr>');
						row.append('<td id="'+table_searchBookName_rangeId+'">'+(i+1)+'</td>');
						var a=result['data'][i].bookId;
						row.append('<td id="'+table_searchBookName_bookId+'">'+a+'</td>');//
						var b=result['data'][i].bookName;
						row.append('<td id="'+table_searchBookName_bookName+'">'+b+'</td>');//
						var c=result['data'][i].bookQuantity;
						row.append('<td id="'+table_searchBookName_bookQuantity+'">'+c+'</td>');//
						var d=result['data'][i].bookUnitPrice;
						row.append('<td id="'+table_searchBookName_bookUnitPrice+'">'+d+'</td>');//
						
						row.appendTo(table);
						rowLength=i+1;
					});
					$("#table_searchBookName").append("</table>");
					document.getElementById("response_searchBookName").innerHTML=rowLength+" records";
				}
				},
				error:function(){
					alert("find error.");
				},
			});
	}
</script>
<br/>
<br/>

<p id="demoBuy">3、buyBook
<button onclick="addRow()">add</button>&nbsp;
<button onclick="calculateCost()">cost</button> 
<p id="totalPrice"></p>
<script type="text/javascript">	
	function addRow()
	{	
		var table=document.getElementById("buy");
		var rowLength=table.rows.length;
		var rowId="row";
		var rangeId="range";
		var selectId="select";
		if(rowLength==1)
		{
			var row=$('<tr id="row1"></tr>');
			row.append('<td id="range1">1</td>');
			var selector=$('<select id="select1"></select>');
		}
		else
		{
			rowId=rowId+rowLength;
			selectId=selectId+rowLength;
			rangeId=rangeId+rowLength;
			var row=$('<tr id="'+rowId+'"></tr>');
			row.append('<td id="'+rangeId+'">'+rowLength+'</td>');
			var selector=$('<select id="'+selectId+'"></select>');
		}		
		$.ajax({
			url: "/test/book/booksOnSale.do",
				type:'GET',
				async:true,
				dataType:'json',
				success:function(result){
					if(result['status']!="1")
					{
						alert(result['errorMsg']);
					}
					else
					{
						$(result['data']).each(function (i){
							 var bookId= result['data'][i].bookId;
							 selector.append('<option value="'+i+'">'+bookId+'</option>');	
						 }); 
						 row.append(selector);
						var priceId="price";
						var quantityId="quantity";
						var inputId="input";
						var deleteId="del";
						var buttonId="button";
						if(rowLength==1)
						{
							row.append('<td id="quantity1"><input type="text" id="input1" value="1" ></input></td>');
							row.append('<td id="1" onclick="changePrice(this)">0</td>');
							row.append('<td id="del1"><button id="button1" onclick="deleteRow(this)">delete</button></td>');
						}
						else
						{
							inputId=inputId+rowLength;
							quantityId=quantityId+rowLength;
							deleteId=deleteId+rowLength;
							buttonId=buttonId+rowLength;
							row.append('<td id="'+quantityId+'"><input type="text" id="'+inputId+'"  value="'+rowLength+'"></input></td>');
							priceId=priceId+rowLength;
							row.append('<td id="'+rowLength+'" onclick="changePrice(this)">0</td>');
							row.append('<td id="'+deleteId+'"><button id="'+buttonId+'" onclick="deleteRow(this)">delete</button></td>');
						}
							
						$("#buy tr:last").after(row);
					}
				},
				error:function(){
					alert('error.');
				}
		});
	}
	function changePrice(obj){
		var table=document.getElementById("buy");
		var id=$(obj).attr('id');
		var a="select";
		var b="input";
		a=a+id;
		b=b+id;
		var d=document.getElementById(a);
		var option=d.options;//所有节点
		var index=d.selectedIndex;//当前选中项索引
		var selectText=option[index].text;//bookId
		var quantityText=document.getElementById(b).value;//quantity
		
		$.ajax({
			url: "/test/book/buy.do",
			type:'POST',
			async:true,
			data:{bookId:selectText, quantity:quantityText},
			dataType:'json',
			success:function(result){
				  var price=JSON.stringify(result);
				  alert(price);
				  //alert(id);
				  document.getElementById(id).innerHTML=price.substring(1,price.length-1);
				},
			error:function(){
				alert('error.');
			}
	});	
		//alert(selectText);
		//alert(quantityText);
	}
	function deleteRow(obj){
		var table=document.getElementById("buy");
		var row=obj.id;
		var id=row.slice(6);
		var intId=parseInt(id);
		
		var rowid="row";
		var rangeid="range";
		var selectId="select"
		var quantityId="quantity";
		var inputId="input";
		var deleteId="del";
		var buttonId="button";
		var index=document.getElementById(rowid+id).rowIndex;
		table.deleteRow(index);
		for(var i=intId+1;i<=table.rows.length;i++)
			{
				var text=(i-1).toString();
				document.getElementById(rangeid+i).innerHTML=text;
				document.getElementById(rowid+i).id=rowid+text;
				document.getElementById(rangeid+i).id=rangeid+text;
				document.getElementById(selectId+i).id=selectId+text;
				document.getElementById(quantityId+i).id=quantityId+text;
				document.getElementById(deleteId+i).id=deleteId+text;
				document.getElementById(buttonId+i).id=buttonId+text;
				document.getElementById(inputId+i).id=inputId+text;
				document.getElementById(i).id=text;		
			}
	}
	
	function calculateCost(){
		var cost=0;
		var table=document.getElementById("buy");
		for(var i=1;i<table.rows.length;i++)
		{
			var price=document.getElementById(i).innerHTML;
			//alert(price.indexOf("input"));
			if(price.indexOf("input")>=0 || price==0)
			{
				alert(price.indexOf("input"));
				cost="wrong input number.";
				break;
			}
			else
			{
			cost=parseFloat(price)+cost; 
			}
		}
		//alert(cost);
		document.getElementById("totalPrice").innerHTML="total price: "+(cost);
		var form=$('#adressStyle');
		form.show();
	}
</script>

<table id="buy" border="1">
	<caption align="top">demandes</caption>
	<tr>
		<th width="200" id="range">range</th>
		<th width="200" id="bookId">bookId</th>
		<th width="200" id="bookQuantity">bookQuantity(a)</th>
		<th width="200" id="price">price(¥)-click to get price</th>
		<th width="200" id="delete">deleteOrNot</th>
	</tr>
</table>
<br/>
<br/>

<div id="adressStyle" style="display:none">
<p id="demoVerify">5、verify</p>
<p>input your delivery adress:
<input id="deliveryAdress" type="text">
<button onclick="demandeVerify()">submit demande</button></p>
<p >your demandeId: </p>
<p id="demandeId"></p>
</div>
<script type="text/javascript">
	function demandeVerify(){
		if(document.getElementById("totalPrice").innerHTML=="" || document.getElementById("totalPrice").innerHTML.indexOf("input")>0||document.getElementById("totalPrice").innerHTML=="0")
		{
			alert("wrong input number");
		}
		else
		{
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
						document.getElementById("demandeId").innerHTML="wrong input number.";
					}
					else
					{
						var userId=result['userId'];
						var table=document.getElementById("buy");
						var list=new Array();
						for(var j=1;j<table.rows.length;j++){
							list.push(j);
						}
						var demandeId;
						$.ajax({
							url: "/test/demande/getRandomDemandeId.do",
							type:'GET',
							async:false,
							dataType:'json',
							success:function(result){
								 demandeId=JSON.stringify(result);
								 //alert(demandeId);
								},
							error:function(){
								alert('error1.');
							}
						});

						$.each(list,function(i){
							var quantityId="input";
							var bookId="select";
							var quantity=document.getElementById(quantityId+list[i]).value;//数量
							var d=document.getElementById(bookId+list[i]);
							var option=d.options;//所有节点
							var index=d.selectedIndex;//当前选中项索引
							var selectText=option[index].text;//bookId
							var adress=document.getElementById("deliveryAdress").value;//地址
							$.ajax({
								url: "/test/demande/verifyByDemandeId.do",
								type:'POST',
								async:false,
								data:{bookId:selectText, quantity:quantity, adress:adress,demandeId:demandeId.substring(1,demandeId.length-1),userId:userId},
								dataType:'json',
								success:function(result){
									 demandeId=JSON.stringify(result);
									},
								error:function(){
									alert('error2.');
								}
							});
						});
						alert("your demandeId is:"+demandeId);
						document.getElementById("demandeId").innerHTML=demandeId.substring(1,demandeId.length-1);
					}
				}
			},
		});
	}
}
</script>
<br/>
<br/>

<p>6-1、delete demande:</p>
<p> input your demandeId:
<input id="demandeId_delete" type="text">
</p>
<p> input your bookId:
<input id="bookId_delete" type="text">
   <button onclick="deleteDemandeByBookIdAndDemandeId()">verify</button>
</p>
<p id="response_deleteDemande"></p>
<script type="text/javascript">
function deleteDemandeByBookIdAndDemandeId()
{
	var demandeId=document.getElementById("demandeId_delete").value;
	var bookId=document.getElementById("bookId_delete").value;
	var r=confirm("verify submit");
	if(r==true)
	{
	$.ajax({
		url:"/test/demande/delete.do",
		type:'POST',
		data:{demandeId:demandeId,bookId:bookId},
		dataType:'json',
		async:true,
		success:function(result){
			var response=JSON.stringify(result);
			alert(response);
			document.getElementById("response_deleteDemande").innerHTML=response;
		},
		error:function(){
			alert("error.");
		},
	});
	}
	else
	{
		alert("annuler");
	}
}
</script>
<br/>
<br/>

<p id="demoPay">6、pay all of demandes</p>
<p>demandeId: <input id="inputDemandeId" type="text">
<button onclick="demandePay()">pay</button></p>
<p id="response"></p>
<script type="text/javascript">
	function demandePay(){
		var r=confirm("submit verify");
		if(r==true)
		{
		var d=document.getElementById("inputDemandeId").value;
		//alert(id);
		$.ajax({
			url: "/test/user/pay.do",
			type:'POST',
			async:true,
			data:{demandeId:d},
			dataType:'json',
			success:function(result){
				 var response=JSON.stringify(result);
				 //alert(demandeId);
				 document.getElementById("response").innerHTML=response;
				},
			error:function(){
				alert('error.');
			}
		});
		}
		else
		{
			alert("annuler.");
		}
	}
</script>
<br/>
<br/>



</body>
</html>