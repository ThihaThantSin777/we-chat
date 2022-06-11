import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';


class CommentWidget extends StatelessWidget {
  const CommentWidget({Key? key,required this.onPressedLiked,required this.isLiked,this.color=Colors.black54,required this.commentAction,required this.onDelete,required this.onEdit,this.id=-1}) : super(key: key);
  final Function onPressedLiked;
  final bool isLiked;
  final Color color;
  final Function commentAction;
  final Function onDelete;
  final Function onEdit;
  final int id;


  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
              IconButton(
                  onPressed: () =>onPressedLiked(),
                  icon:  Icon(
                    isLiked?Icons.favorite:Icons.favorite_border,
                    size: kPadSpace40x,
                    color: isLiked?Colors.red:color,
                  )),

        const SizedBox(
          width: kPadSpace10x,
        ),
        IconButton(
            onPressed: () =>commentAction(),
            icon:  Icon(
              Icons.comment,
              size: kPadSpace40x,
              color: color,
            )),
        const SizedBox(
          width: kPadSpace10x,
        ),
        PopupMenuButton(
          onSelected: (value){
            if(value=='Edit'){
              onEdit();
            }
          },
          icon:  Icon(Icons.more_horiz,size: kPadSpace40x,color: color,),
            itemBuilder: (context)=>[
           const  PopupMenuItem(
              value: 'Edit',
              child:   Text('Edit'),
          ),
           PopupMenuItem(
             value: 'Delete',
               child: const Text('Delete'),
             onTap: ()=>onDelete(),
           ),
        ])
      ],
    );
  }
}
