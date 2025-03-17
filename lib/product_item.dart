import 'package:app_backend/models/product.dart';
import 'package:app_backend/utils/http_utils.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final ValueChanged<bool> productItemSelectedStateChanged;
  final bool isSelected;
  const ProductItem(
      {super.key,
      required this.product,
      required this.productItemSelectedStateChanged,
      required this.isSelected});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isSelected = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = widget.isSelected;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
       setState(() {
         isSelected = !widget.isSelected;
         widget.productItemSelectedStateChanged(isSelected);
       });
      },
      onLongPress: (){
        Navigator.pushNamed(
            context, '/products',
            arguments: { 'product': widget.product
            }
        );
      },
      child: Stack(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(4.0),
            child: Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              child: Image.network(widget.product.image, color: Colors.black.withOpacity(isSelected?0.9:0),
              colorBlendMode: BlendMode.color,)
              ),
            ),
          widget.isSelected ? const Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.check_circle, color: Colors.blue,)
            ),
          ): Container()

        ],
      )
    );
  }
}
