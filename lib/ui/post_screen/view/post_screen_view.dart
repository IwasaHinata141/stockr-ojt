import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../ui/dialog/post_screen_dialog.dart';
import '../view_model/post_screen_view_model.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({
    super.key,
    required this.index,
    required this.content,
    required this.checkOfPriviousList,
  });

  final int index;
  final String content;
  final bool checkOfPriviousList;

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.content.isEmpty ? '' : widget.content);
    _controller.addListener(() {
      ref.read(textStateNotifierProvider.notifier).updateText(_controller.text);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!ref.read(checkOfModalStateProvider)) {
        _focusNode.requestFocus();
      } else {
        _focusNode.unfocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postNotifier = ref.read(postScreenViewModelProvider.notifier);
    final textState = ref.watch(textStateNotifierProvider);
    // final isModalVisible = ref.watch(checkOfModalStateProvider);
    final modalStateNotifier = ref.read(checkOfModalStateProvider.notifier);

    return SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFEAEEEF),
                      width: 1,
                    ),
                  ),
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          _focusNode.unfocus();
                          if (_controller.text.isEmpty) {
                            Navigator.pop(context);
                          } else {
                            modalStateNotifier.updateCheck(true);
                            returnPostScreenDialog(context, modalStateNotifier);
                          }
                        },
                        child: const Icon(
                                                  Icons.close_outlined,
                                                  size: 30,
                                                )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: textState.isEmpty
                              ? const Color(0xFFCAD5D6)
                              : const Color(0xFF52C2CD),
                        ),
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            if (widget.checkOfPriviousList) {
                              postNotifier.updateStock(widget.index, _controller.text);
                            } else {
                              postNotifier.post(_controller.text);
                            }
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("ストックする",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _controller, // コントローラーを設定
                    focusNode: _focusNode, // フォーカスノードを設定
                    decoration: const InputDecoration(
                      border: InputBorder.none, // 枠を見えないようにする
                      hintText: '気づいたことをストックしましょう',
                    ),
                    maxLines: null, // 複数行の入力を許可
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}