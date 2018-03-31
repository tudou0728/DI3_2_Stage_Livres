<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.controller.*"%>
<html>
<script src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js"></script>

<body>
<p>4-2、search demande：demandeId:
<input id="SearchDemande" type="text"></p>
<p>user search demande:
<button onclick="getDemande()">search</button></p>
<p id="number_SearchDemande"></p>
<div id="userDemandeByDemandeId_table"></div>

<p>user's demandes not pay (shopping trolley):
<button onclick="notPayDemandes()">search</button></p>
<p id="number_notPayDemandes"></p>
<div id="userDemandeNotPay_table"></div>
<p id="deleteResponse"></p>	
	<script type="text/javascript">
	function signNature(delivery,demande){
		var url="/test/user/inverseArrive.do?deliveryId="+delivery+"&"+"demandeId="+demande;
		window.open(url);
	}
		
		function getDemande(){
			var demandeId=document.getElementById("SearchDemande").value;
			demandeId="%"+demandeId+"%";
			$.ajax({
				url:"http://localhost:8080/test/user/verifySession.do",
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
						//alert(id);
						document.getElementById("userDemandeByDemandeId_table").innerHTML="";
						var table=$('<table border="1">');
						table.appendTo($("#userDemandeByDemandeId_table"));
						var row1=$('<tr></tr>');
						row1.append('<th width=100 id="range_demandeByUser">range</th>');
						row1.append('<th width=200 id="demandeIdSearchDemande">demandeId</th>');
						row1.append('<th width=200 id="userIdSearchDemande">userId</th>');
						row1.append('<th width=200 id="bookIdSearchDemande">bookId</th>');
						
						row1.append('<th width=100 id="quantitySearchDemande">quantity</th>');
						row1.append('<th width=100 id="totalPriceSearchDemande">totalPrice</th>');
						row1.append('<th width=200 id="createDateSearchDemande">createDate</th>');
						row1.append('<th width=200 id="detailsSearchDemande">details</th>');
						row1.appendTo(table);	
						$.ajax({
							url:"http://localhost:8080/test/demande/getDemandeLikeDid.do",
							type:'POST',
							data:{demandeId:demandeId,userId:id},
							async:true,
							dataType:'json',
							success:function(result){
								var number;
								if(result['status']!="1")
								{
									alert(result['errorMsg']);
									document.getElementById("number_SearchDemande").innerHTML="0 records";
								}
								else
								{
								$(result['data']).each(function(i){
									//var rowLength=$("table tr").length;
									var rowId="row";
									var range_demandeByUser="range_demandeByUser";
									var demandeIdSearchDemande="demandeIdSearchDemande";
									var userIdSearchDemande="userIdSearchDemande";
									var bookIdSearchDemande="bookIdSearchDemande";
									
									var quantitySearchDemande="quantitySearchDemande";
									var totalPriceSearchDemande="totalPriceSearchDemande";
									var createDateSearchDemande="createDateSearchDemande";
									var detailsSearchDemande="detailsSearchDemande";

									rowId=rowId+(i+1);
									range_demandeByUser=range_demandeByUser+(i+1);
									demandeIdSearchDemande=demandeIdSearchDemande+(i+1);
									userIdSearchDemande=userIdSearchDemande+(i+1);
									bookIdSearchDemande=bookIdSearchDemande+(i+1);
							
									quantitySearchDemande=quantitySearchDemande+(i+1);
									totalPriceSearchDemande=totalPriceSearchDemande+(i+1);
									createDateSearchDemande=createDateSearchDemande+(i+1);
									detailsSearchDemande=detailsSearchDemande+(i+1);
									var dId=result['data'][i].demandeId;
									//alert(dId);
									
									var row=$('<tr id="'+rowId+'"></tr>');
									row.append('<td id="'+range_demandeByUser+'">'+(i+1)+'</td>');
									row.append('<td id="'+demandeIdSearchDemande+'">'+dId+'</td>');
									var a=result['data'][i].userId;
									row.append('<td id="'+userIdSearchDemande+'">'+a+'</td>');//
									
									var b=result['data'][i].bookId;
									row.append('<td id="'+bookIdSearchDemande+'">'+b+'</td>');//
									
									var c=result['data'][i].quantity;
									row.append('<td id="'+quantitySearchDemande+'">'+c+'</td>');//
									var d=result['data'][i].totalPrice;
									row.append('<td id="'+totalPriceSearchDemande+'">'+d+'</td>');//
									var e=result['data'][i].createDate;
									var time=new Date(e).toLocaleString().substring(0, 19)
									row.append('<td id="'+createDateSearchDemande+'">'+time+'</td>');//
									//alert(dId);
									if(result['delivery'][i]==1)
									{
										row.append('<td id="'+detailsSearchDemande+'">deja sign <button onclick="demandeDetails('+dId+','+b+')">details</button>&nbsp;<button onclick="needRefund('+dId+','+b+')">refund</button></td>');//
									}
									else
									{
										row.append('<td id="'+detailsSearchDemande+'"><button onclick="demandeDetails('+dId+','+b+')">details</button></td>');//
									}
									row.appendTo(table);
									number=i+1;
								});
								 $("#userDemandeByDemandeId_table").append("</table>");
								 document.getElementById("number_SearchDemande").innerHTML=number+" records";
								}
							},
							error:function(){
								alert('error3.');
							}
						});
					}
				},
			});
		}
		function needRefund(dId,b)
		{
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
						url="http://localhost:8080/test/comment/inverseToRefund.do?"+window.btoa("demandeId="+dId+"&bookId="+b);
						window.open(url);				
					}
				}
			})	
		}
		function demandeDetails(dId,b){
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
						url="http://localhost:8080/test/user/inverseDemandeDetails.do?"+window.btoa("demandeId="+dId+"&bookId="+b);
						window.open(url);					
					}
				}
			})
		}
		var allDemande="list:";
		function notPayDemandes(){
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
					var number;
					document.getElementById("userDemandeNotPay_table").innerHTML="";
					var table=$('<table border="1">');
					table.appendTo($("#userDemandeNotPay_table"));
					var row1=$('<tr></tr>');
					row1.append('<th width=100 id="range_demandeByUser">range</th>');
					row1.append('<th width=200 id="demandeIdSearchDemande">demandeId</th>');
					row1.append('<th width=200 id="userIdSearchDemande">userId</th>');
					row1.append('<th width=200 id="bookIdSearchDemande">bookId</th>');
					row1.append('<th width=200 id="bookNameSearchDemande">bookName</th>');
					row1.append('<th width=100 id="quantitySearchDemande">quantity</th>');
					row1.append('<th width=100 id="totalPriceSearchDemande">totalPrice</th>');
					row1.append('<th width=200 id="createDateSearchDemande">createDate</th>');
					row1.append('<th width=200 id="payDemande">payDemande</th>');
					row1.appendTo(table);	
					$.ajax({
						url:"http://localhost:8080/test/demande/listDemandeNotPay.do",
						type:'POST',
						async:true,
						data:{userId:id},
						dataType:'json',
						success:function(result){
							if(result['status']!="1")
							{
								alert(result['errorMsg']);
								document.getElementById("number_notPayDemandes").innerHTML="0 records";
							}
							else
							{
								
							$(result['data']).each(function(i){
							//	var rowLength=$("table tr").length;
								var rowId="row";
								var range_demandeByUser="range_demandeByUser";
								var demandeIdSearchDemande="demandeIdSearchDemande";
								var userIdSearchDemande="userIdSearchDemande";
								var bookIdSearchDemande="bookIdSearchDemande";
								var bookNameSearchDemande="bookNameSearchDemande";
								var quantitySearchDemande="quantitySearchDemande";
								var totalPriceSearchDemande="totalPriceSearchDemande";
								var createDateSearchDemande="createDateSearchDemande";
								var payDemande="payDemande";

								rowId=rowId+(i+1);
								range_demandeByUser=range_demandeByUser+(i+1);
								demandeIdSearchDemande=demandeIdSearchDemande+(i+1);
								userIdSearchDemande=userIdSearchDemande+(i+1);
								bookIdSearchDemande=bookIdSearchDemande+(i+1);
								bookNameSearchDemande=bookNameSearchDemande+(i+1);
								quantitySearchDemande=quantitySearchDemande+(i+1);
								totalPriceSearchDemande=totalPriceSearchDemande+(i+1);
								createDateSearchDemande=createDateSearchDemande+(i+1);
								payDemande=payDemande+(i+1);
								var dId=result['data'][i].demandeId;
								//alert(dId);
								
								var row=$('<tr id="'+rowId+'"></tr>');
								row.append('<td id="'+range_demandeByUser+'">'+(i+1)+'</td>');
								row.append('<td id="'+demandeIdSearchDemande+'">'+dId+'</td>');
								var a=result['data'][i].userId;
								row.append('<td id="'+userIdSearchDemande+'">'+a+'</td>');//
					
								var b=result['data'][i].bookId;
								row.append('<td id="'+bookIdSearchDemande+'">'+b+'</td>');//
						
								var bookName;
								var bookUnitPrice;
								
								$.ajax({
									url:"http://localhost:8080/test/book/selectBook.do",
									type:'POST',
									async:false,
									data:{bookId:b},
									dataType:'json',
									success:function(result){
										if(result['status']==0)
										{
											alert(result['errorMsg']);
										}
										else
										{
											
											bookName=result['data'].bookName;
											bookUnitPrice=result['data'].bookUnitPrice;
										}
									},
									error:function(){
										alert('error2.');
									}
								});
								
								row.append('<td id="'+bookNameSearchDemande+'">'+bookName+'</td>');//
								
								var c=result['data'][i].quantity;
								row.append('<td id="'+quantitySearchDemande+'">'+c+'</td>');//
								var d=result['data'][i].totalPrice;
								row.append('<td id="'+totalPriceSearchDemande+'">'+d+'</td>');//
								var e=result['data'][i].createDate;
								var time=new Date(e).toLocaleString().substring(0, 19)
								row.append('<td id="'+createDateSearchDemande+'">'+time+'</td>');//
								//dId="@"+dId;
								allDemande=allDemande+"&demandeId="+dId+"&bookId="+b+"&totalPrice="+d;
								row.append('<td id="'+payDemande+'"><button onclick="payDemande('+dId+','+b+','+bookUnitPrice+')">pay</button>&nbsp<button onclick="deleteDemande('+dId+','+b+')">delete</button></td>');
								
								row.appendTo(table);
								number=i+1;
							});
							//var temp=eval('('+allDemande+')');
							 $("#userDemandeNotPay_table").append("</table>");
							 $("#userDemandeNotPay_table").append('<button onclick="payAllDemandes(allDemande)">pay all</button>');
							 document.getElementById("number_notPayDemandes").innerHTML=number+" records";
							}
						},
						error:function(){
							alert('error3.');
						}
					});
				}	
				},
				});		
		}
		function deleteDemande(demandeId,bookId)
		{
			$.ajax({
				url:"http://localhost:8080/test/demande/delete.do",
				type:'POST',
				async:false,
				data:{demandeId:demandeId,bookId:bookId},
				dataType:'json',
				success:function(result){
					document.getElementById("deleteResponse").innerHTML=result;
					}
				});
		}
		
		function payDemande(demandeId,bookId,unitPrice)
		{
			var url="/test/demande/toDeliverPay.do?demandeId="+demandeId+"&bookId="+bookId+"&unitprice="+unitPrice;
			window.open(url);
		}
		
		function payAllDemandes(list)
		{
			//alert(list);
			$.ajax({
				url:"http://localhost:8080/test/demande/changeDemandeId.do",
				type:'POST',
				async:false,
				data:{demande:list},
				dataType:'json',
				success:function(result){
					url="/test/demande/toDeliverPay.do?"+result;
					window.open(url);
				}
			});
		}
	</script>

<br/>
<br/>


</body>
</html>