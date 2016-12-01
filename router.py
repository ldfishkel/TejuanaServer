#!/usr/bin/env python
import web

from rest.product import *

urls = (
    '/producttypes'   , 'ProductTypeList',      #GET
    '/product/(.*)'   , 'ProductsByType' ,      #GET
    '/product'        , 'Product',              #POST #PUT #GET
    '/productsupplies', 'ProductSupplies',      #GET
    '/tags'           , 'Tags',                 #GET #POST
    '/producttype'    , 'AddProductType'        #POST
)

app = web.application(urls, globals())

if __name__ == "__main__":
    app.run()

