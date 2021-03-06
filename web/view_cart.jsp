<%-- 
    Document   : view_cart
    Created on : 22 Dec, 2020, 1:04:14 PM
    Author     : karan
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="vmm.DBLoader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!--
author: W3layouts
author URL: http://w3layouts.com
License: Creative Commons Attribution 3.0 Unported
License URL: http://creativecommons.org/licenses/by/3.0/
-->
<!DOCTYPE html>
<html>
    <head>
        <title>Super Market an Ecommerce Online Shopping Category Flat Bootstrap Responsive Website Template | Checkout :: w3layouts</title>
        <!-- for-mobile-apps -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Super Market Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false);
            function hideURLbar(){ window.scrollTo(0,1); } </script>
        <!-- //for-mobile-apps -->
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
        <link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
        <!-- font-awesome icons -->
        <link href="css/font-awesome.css" rel="stylesheet"> 
        <!-- //font-awesome icons -->
        <!-- js -->
        <script src="js/jquery-1.11.1.min.js"></script>
        <!-- //js -->
        <link href='//fonts.googleapis.com/css?family=Raleway:400,100,100italic,200,200italic,300,400italic,500,500italic,600,600italic,700,700italic,800,800italic,900,900italic' rel='stylesheet' type='text/css'>
        <link href='//fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
        <!-- start-smoth-scrolling -->
        <script type="text/javascript" src="js/move-top.js"></script>
        <script type="text/javascript" src="js/easing.js"></script>
        <script type="text/javascript">
            jQuery(document).ready(function ($) {
                $(".scroll").click(function (event) {
                    event.preventDefault();
                    $('html,body').animate({scrollTop: $(this.hash).offset().top}, 1000);
                });
            });
        </script>
        <script>

            function deleteitemcart(cid)
            {
                var option = confirm(" Are you sure you want to delete it? ");
                if (option)
                {

                    var xhr = new XMLHttpRequest();

                    xhr.onreadystatechange = function ()
                    {
                        if (xhr.readyState === 4 && xhr.status == 200)
                        {
                            //get response from server
                            var res = xhr.responseText;

                            res = res.trim();
                            if (res == "success")
                            {
                                alert("Deleted Successfully");
                                location.href = "view_cart.jsp";

                            } else
                            {
                                alert("Some Error occured while deleting");
                            }
                        }
                    };


                    var querystring = "cid=" + cid;
                    xhr.open("GET", "delete_cart_item?" + querystring, true);
                    xhr.send();
                }
            }

        </script>
        <!-- start-smoth-scrolling -->
    </head>

    <body>
        <%@include file="header.jsp" %>
        <!-- breadcrumbs -->
        <div class="breadcrumbs">
            <div class="container">
                <ol class="breadcrumb breadcrumb1">
                    <li><a href="index.jsp"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>Home</a></li>
                    <li class="active">Checkout Page</li>
                </ol>
            </div>
        </div>
        <!-- //breadcrumbs -->
        <!-- checkout -->
        <div class="checkout">
            <div class="container">
                <h2>Your shopping cart contains: <span></span></h2>
                <div class="checkout-right">
                    <table class="timetable_sub">
                        <thead>
                            <tr>
                                <th>SL No.</th>	
                                <th>Product</th>
                                <th>Quantity</th>
                                <th>Product Name</th>
                                <th>Total</th>

                                <th>Price</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <%
                            if (session.getAttribute("username") != null) {
                                String username = session.getAttribute("username").toString();
                                ResultSet rs = DBLoader.executeQuery("select * from cart where username='" + username + "' ");
                                int s = 1;
                                int total = 0;
                                while (rs.next()) {
                                    int cid = rs.getInt("cid");
                                    String name = rs.getString("productname");
                                    int price = rs.getInt("price");
                                    int qty = rs.getInt("qty");
                                    int pid = rs.getInt("pid");
                                    total = total + (price * qty);

                                    ResultSet rs1 = DBLoader.executeQuery("select * from products where pid= " + pid);
                                    rs1.next();
                                    String photo = rs1.getString("photo");

                        %>
                        <tr class="rem1">
                            <td class="invert"><%=s%></td>
                            <td class="invert-image"><a href="single.html"><img src="<%=photo%>" alt=" "  class="img-responsive"  style="width:50px;height:60px"/></a></td>
                            <td class="invert">
                                <div class="quantity"> 
                                    <div class="quantity-select">                           
                                        <div class="entry value-minus" >&nbsp;</div>
                                        <div class="entry value"><span> <%=qty%> </span></div>
                                        <div class="entry value-plus active">&nbsp;</div>
                                    </div>
                                </div>
                            </td>
                            <td class="invert"><%=name%></td>

                            <td class="invert">&#x20b9;<%=price%></td>
                            <td class="invert">&#x20b9;<%=price * qty%></td>
                            <td class="invert">
                                <div class="rem">
                                    <div class="close1" onclick="deleteitemcart('<%=cid%>')"> 
                                    </div>
                                </div>

                            </td>
                        </tr>
                        <%
                                s++;
                            }
                        %>



                        <tr class="rem1">
                            <td class="invert"></td>
                            <td class="invert"></td>
                            <td class="invert"></td>
                            <td class="invert"><b>Total</b></td>
                            <td class="invert"><b> &#x20b9;<%=total%></b></td>
                            <td class="invert"></td>
                            <td  class="invert"></td >




                        </tr>

                        <%
                            }
                        %>

                        <!--quantity-->
                        <script>
                            $('.value-plus').on('click', function () {
                                var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10) + 1;
                                divUpd.text(newVal);
                            });

                            $('.value-minus').on('click', function () {
                                var divUpd = $(this).parent().find('.value'), newVal = parseInt(divUpd.text(), 10) - 1;
                                if (newVal >= 1)
                                    divUpd.text(newVal);
                            });
                        </script>
                        <!--quantity-->
                    </table>
                </div>
                <div class="checkout-right-basket">
                    <a href="placeorder.jsp"><span class="glyphicon glyphicon-menu-left" aria-hidden="true"></span>Place Order</a>
                </div> 
            </div>
        </div>
        <!-- //checkout -->
        <!-- //footer -->
        <div class="footer">
            <div class="container">
                <div class="w3_footer_grids">
                    <div class="col-md-3 w3_footer_grid">
                        <h3>Contact</h3>

                        <ul class="address">
                            <li><i class="glyphicon glyphicon-map-marker" aria-hidden="true"></i>1234k Avenue, 4th block, <span>New York City.</span></li>
                            <li><i class="glyphicon glyphicon-envelope" aria-hidden="true"></i><a href="mailto:info@example.com">info@example.com</a></li>
                            <li><i class="glyphicon glyphicon-earphone" aria-hidden="true"></i>+1234 567 567</li>
                        </ul>
                    </div>
                    <div class="col-md-3 w3_footer_grid">
                        <h3>Information</h3>
                        <ul class="info"> 
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="about.html">About Us</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="contact.html">Contact Us</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="short-codes.html">Short Codes</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="faq.html">FAQ's</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="products.html">Special Products</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3 w3_footer_grid">
                        <h3>Category</h3>
                        <ul class="info"> 
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="groceries.html">Groceries</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="household.html">Household</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="personalcare.html">Personal Care</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="packagedfoods.html">Packaged Foods</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="beverages.html">Beverages</a></li>
                        </ul>
                    </div>
                    <div class="col-md-3 w3_footer_grid">
                        <h3>Profile</h3>
                        <ul class="info"> 
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="products.html">Store</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="checkout.html">My Cart</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="login.html">Login</a></li>
                            <li><i class="fa fa-arrow-right" aria-hidden="true"></i><a href="registered.html">Create Account</a></li>
                        </ul>


                    </div>
                    <div class="clearfix"> </div>
                </div>
            </div>

            <div class="footer-copy">

                <div class="container">
                    <p>© 2017 Super Market. All rights reserved | Design by <a href="http://w3layouts.com/">W3layouts</a></p>
                </div>
            </div>

        </div>	
        <div class="footer-botm">
            <div class="container">
                <div class="w3layouts-foot">
                    <ul>
                        <li><a href="#" class="w3_agile_facebook"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                        <li><a href="#" class="agile_twitter"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                        <li><a href="#" class="w3_agile_dribble"><i class="fa fa-dribbble" aria-hidden="true"></i></a></li>
                        <li><a href="#" class="w3_agile_vimeo"><i class="fa fa-vimeo" aria-hidden="true"></i></a></li>
                    </ul>
                </div>
                <div class="payment-w3ls">	
                    <img src="images/card.png" alt=" " class="img-responsive">
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
        <!-- //footer -->	
        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>
        <!-- top-header and slider -->
        <!-- here stars scrolling icon -->
        <script type="text/javascript">
                            $(document).ready(function () {
                                /*
                                 var defaults = {
                                 containerID: 'toTop', // fading element id
                                 containerHoverID: 'toTopHover', // fading element hover id
                                 scrollSpeed: 1200,
                                 easingType: 'linear' 
                                 };
                                 */

                                $().UItoTop({easingType: 'easeOutQuart'});

                            });
        </script>
        <!-- //here ends scrolling icon -->
        <script src="js/minicart.min.js"></script>
        <script>
                            // Mini Cart
                            paypal.minicart.render({
                                action: '#'
                            });

                            if (~window.location.search.indexOf('reset=true')) {
                                paypal.minicart.reset();
                            }
        </script>
        <!-- main slider-banner -->
        <script src="js/skdslider.min.js"></script>
        <link href="css/skdslider.css" rel="stylesheet">
        <script type="text/javascript">
                            jQuery(document).ready(function () {
                                jQuery('#demo1').skdslider({'delay': 5000, 'animationSpeed': 2000, 'showNextPrev': true, 'showPlayButton': true, 'autoSlide': true, 'animationType': 'fading'});

                                jQuery('#responsive').change(function () {
                                    $('#responsive_wrapper').width(jQuery(this).val());
                                });

                            });
        </script>	
        <!-- //main slider-banner --> 

    </body>
</html>