#!/usr/bin/env python
import web

from rest.product import *
from rest.supply import *
from rest.order import *
from rest.shipping import *
from rest.pickup import *
from rest.purchase import *
from rest.security import *

urls = (
    #Admin
    '/token'          , 'Token',

    '/producttypes'   , 'ProductTypeList',      
    '/product/(.*)'   , 'ProductsByType',      
    '/product'        , 'Product',               
    '/productsupplies', 'ProductSupplies',      
    '/tags'           , 'Tags',                  
    '/producttype'    , 'AddProductType',      

    '/supplydata'     , 'SupplyData',
    '/supply'         , 'Supply',
    '/supplymov'      , 'SupplyMov',

    '/order'          , 'Order',
    '/order/(.*)'     , 'Order',
    '/orderr'         , 'Orderr',

    '/shipping/(.*)'  , 'Shipping',
    '/shippingstatus' , 'ShippingStatus',

    '/pickup/(.*)'    , 'PickUp',
    '/pickupstatus'   , 'PickUpStatus',

    '/purchase/(.*)'  , 'Purchase',
    '/purchase'       , 'Purchase',
    '/purchasestatus' , 'PurchaseStatus',
    '/client'         , 'Client',

)

app = web.application(urls, globals())

if __name__ == "__main__":
    app.run()

