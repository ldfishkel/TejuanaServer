USE Tejuana;
/***********************************************************************************************************/
/*************************************** SEED **************************************************************/
/***********************************************************************************************************/

INSERT INTO Tejuana.Product_Type VALUES (1, 'Leodan');
INSERT INTO Tejuana.Product VALUES (1, 'Leodan deluxe', 300, 'XL', 1, 0, 120);
INSERT INTO Tejuana.Product VALUES (2, 'Leodan platinum', 350, 'XL', 1, 0, 120);
INSERT INTO Tejuana.Supply VALUES (1, 'Hilo Rojo', 0, NULL);
INSERT INTO Tejuana.Supply VALUES (2, 'Hilo Crudo', 0, NULL);
INSERT INTO Tejuana.Supply VALUES (3, 'Hilo Amarillo', 0, NULL);
-- INSERT INTO Tejuana.Product_Supply VALUES (1, 1, 50);
-- INSERT INTO Tejuana.Product_Supply VALUES (1, 2, 150);
INSERT INTO Tejuana.Product_Supply VALUES (2, 3, 50);
INSERT INTO Tejuana.Product_Supply VALUES (2, 2, 150);

INSERT INTO Tejuana.Product_Type VALUES (2, 'Top Mery');
INSERT INTO Tejuana.Product VALUES (3, 'Top Mery Rosa', 200, 'S', 2, 0, 100);
INSERT INTO Tejuana.Product VALUES (4, 'Top Mery Crudo', 220, 'M', 2, 0, 100);
INSERT INTO Tejuana.Supply VALUES (4, 'Hilo Rosa', 0, NULL);
INSERT INTO Tejuana.Product_Supply VALUES (3, 4, 200);
INSERT INTO Tejuana.Product_Supply VALUES (4, 2, 250);

INSERT INTO Tejuana.Product_Image VALUES (1, 1, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product_Image VALUES (2, 1, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');
INSERT INTO Tejuana.Product_Image VALUES (3, 2, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product_Image VALUES (4, 2, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');
INSERT INTO Tejuana.Product_Image VALUES (5, 3, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product_Image VALUES (6, 3, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');
INSERT INTO Tejuana.Product_Image VALUES (7, 4, 'https://scontent-gru2-1.xx.fbcdn.net/t45.5328-0/p180x540/14057493_1212721252133415_1344293813_n.jpg');
INSERT INTO Tejuana.Product_Image VALUES (8, 4, 'https://fb-s-d-a.akamaihd.net/h-ak-xpt1/v/t1.0-9/15178202_1358275414192090_2732619573659142335_n.jpg?oh=9185a9027c5e552a90741ab3d7aea728&oe=58FC35F1&__gda__=1490022246_44d183b51eb2d5bbff97ab7da99ef6d5');


INSERT INTO Tejuana.Tag VALUES (1, 'verano');
INSERT INTO Tejuana.Tag VALUES (2, 'invierno');
INSERT INTO Tejuana.Tag VALUES (3, 'top');
INSERT INTO Tejuana.Tag VALUES (4, 'colorido');
INSERT INTO Tejuana.Tag VALUES (5, 'calor');
INSERT INTO Tejuana.Tag VALUES (6, 'playa');

INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 1);
INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 3);
INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 5);
INSERT INTO Tejuana.Product_Type_Tag VALUES (2, 2);
INSERT INTO Tejuana.Product_Type_Tag VALUES (2, 4);
INSERT INTO Tejuana.Product_Type_Tag VALUES (2, 5);
INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 6);
INSERT INTO Tejuana.Product_Type_Tag VALUES (1, 4);
INSERT INTO Tejuana.Product_Type_Tag VALUES (2, 3);

INSERT INTO Tejuana.Purchase_Via VALUES (1, 'Web');
INSERT INTO Tejuana.Purchase_Via VALUES (2, 'Facebook');
INSERT INTO Tejuana.Purchase_Via VALUES (3, 'Instagram');
INSERT INTO Tejuana.Purchase_Via VALUES (4, 'MercadoLibre');
INSERT INTO Tejuana.Purchase_Via VALUES (5, 'Other');

INSERT INTO Tejuana.Purchase_Status VALUES (1, 'Orden Generada');
INSERT INTO Tejuana.Purchase_Status VALUES (2, 'Orden Cancelada');
INSERT INTO Tejuana.Purchase_Status VALUES (3, 'Pago');
INSERT INTO Tejuana.Purchase_Status VALUES (4, 'Enviado');
INSERT INTO Tejuana.Purchase_Status VALUES (5, 'Retirado');
INSERT INTO Tejuana.Purchase_Status VALUES (6, 'Calificado');

INSERT INTO Tejuana.Shipping_Status VALUES (1, 'En Produccion');
INSERT INTO Tejuana.Shipping_Status VALUES (2, 'Listo Para Enviar');
INSERT INTO Tejuana.Shipping_Status VALUES (3, 'Enviado');
INSERT INTO Tejuana.Shipping_Status VALUES (4, 'Recibido');
INSERT INTO Tejuana.Shipping_Status VALUES (5, 'Rebotado');
INSERT INTO Tejuana.Shipping_Status VALUES (6, 'Cancelado');

INSERT INTO Tejuana.Pick_Up_Status VALUES (1, 'En Produccion');
INSERT INTO Tejuana.Pick_Up_Status VALUES (2, 'Listo Para Retirar');
INSERT INTO Tejuana.Pick_Up_Status VALUES (3, 'Retirado');
INSERT INTO Tejuana.Pick_Up_Status VALUES (4, 'Cancelado');
INSERT INTO Tejuana.Pick_Up_Status VALUES (5, 'Rebotado');

INSERT INTO Tejuana.Client VALUES (1, 'Pepito1', 'pepito1@jose.com', 123456781, 36157481);
INSERT INTO Tejuana.Client VALUES (2, 'Pepito2', 'pepito2@jose.com', 123456782, 36157482);
INSERT INTO Tejuana.Client VALUES (3, 'Pepito3', 'pepito3@jose.com', 123456783, 36157483);

INSERT INTO Tejuana.Address VALUES (1, 'direccion 1', 'zipcode1', 'province1', 'region1', 'district1', TRUE, 1);
INSERT INTO Tejuana.Address VALUES (2, 'direccion 2', 'zipcode1', 'province1', 'region1', 'district1', FALSE, 1);
INSERT INTO Tejuana.Address VALUES (3, 'direccion 3', 'zipcode1', 'province1', 'region1', 'district1', FALSE, 1);

INSERT INTO Tejuana.Address VALUES (4, 'direccion 4', 'zipcode1', 'province1', 'region1', 'district1', TRUE, 2);
INSERT INTO Tejuana.Address VALUES (5, 'direccion 5', 'zipcode1', 'province1', 'region1', 'district1', FALSE, 2);
INSERT INTO Tejuana.Address VALUES (6, 'direccion 6', 'zipcode1', 'province1', 'region1', 'district1', FALSE, 2);

INSERT INTO Tejuana.Address VALUES (7, 'direccion 7', 'zipcode1', 'province1', 'region1', 'district1', TRUE, 3);


INSERT INTO Tejuana.ThrowException VALUES ('No se puede actualizar el stock sin los insumos necesarios correspondientes');
