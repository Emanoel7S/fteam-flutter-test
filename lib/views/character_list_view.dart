import 'package:flutter/material.dart';
import '../viewmodels/character_viewmodel.dart';
import '../widgets/character_card.dart';
import '../widgets/character_detail_dialog.dart';

class CharacterListView extends StatefulWidget {
  const CharacterListView({super.key});

  @override
  _CharacterListViewState createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  final CharacterViewModel _viewModel = CharacterViewModel();

  @override
  void initState() {
    super.initState();

    _viewModel.addListener(() {
      setState(() {});
    });

    _viewModel.fetchCharacters();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int pageSize = 20;
    final int start = (_viewModel.currentPage - 1) * pageSize;
    final int end = (_viewModel.currentPage * pageSize).clamp(0, _viewModel.characters.length);

    final List charactersToShow = _viewModel.characters.sublist(start, end);
    return Scaffold(
      appBar: AppBar(title: const Text('Personagens',
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromRGBO(20, 23, 29, 100),
        centerTitle: true,),
      body: Container(
        color: const Color.fromRGBO(39, 43, 51, 1),
        child: Column(
          children: [
            Expanded(
              child: _viewModel.isLoading && _viewModel.characters.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  :


              ListView.builder(
                itemCount: charactersToShow.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CharacterDetailDialog(character: charactersToShow[index]),
                      );
                    },
                    child: CharacterCard(character: charactersToShow[index]),
                  );
                },
              ),
            ),
            Container(
              color: Color.fromRGBO(20, 23, 29, 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Cor de fundo cinza
                    ),
                    onPressed: _viewModel.isLoading || _viewModel.currentPage <= 1
                        ? null
                        : () {
                      _viewModel.fetchPreviousPage();
                    },
                    child: const Text('Anterior',style: TextStyle(color: Colors.grey),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all( 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:
                        Text(
                          '${_viewModel.currentPage}',
                          style: const TextStyle(fontSize: 25, color: Colors.grey),
                        ),

                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _viewModel.isLoading || _viewModel.currentPage >= _viewModel.totalPages
                        ? null
                        : () {
                      _viewModel.fetchNextPage();
                    },
                    child: const Text('Próxima', style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
