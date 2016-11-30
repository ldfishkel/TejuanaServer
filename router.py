#!/usr/bin/env python
import web

from rest.product import *

urls = (
    '/producttypes'   , 'ProductTypeList',      #GET
    '/products'       , 'ProductList',          #GET
    '/products/(.*)'  , 'ProductListBy' ,       #GET
    '/product'        , 'AddProduct',           #POST
    '/product/(.*)'   , 'UpdateProduct',        #POST
    '/productsupplies', 'ProductSupplies'       #GET
)

app = web.application(urls, globals())

if __name__ == "__main__":
    app.run()

