# Tus Libros
## Crate Cart
- http://localhost:8080/createCart?user=lucas&pass=123
## Add To Cart
- http://localhost:8080/addToCart?cartID=1&bookISBN=validBook&bookQuantity=2
- http://localhost:8080/addToCart?cartID=1&bookISBN=anotherValidBook&bookQuantity=3
 
## List Cart
- http://localhost:8080/listCart?cartID=1
## Checkout
- http://localhost:8080/checkout?cartID=1&ccn=3232&cced=022021&cco=mycard
## List Purchases
- http://localhost:8080/listPurchases?user=lucas&pass=123