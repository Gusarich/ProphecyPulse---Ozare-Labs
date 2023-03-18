import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/features/search/bloc/search_bloc.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    required this.searchController,
    super.key,
  });

  final TextEditingController searchController;

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String selectedSport = 'soccer';
  String hintText = 'Search Soccer Teams';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: TextField(
                scrollPadding: const EdgeInsets.only(left: 22),
                textInputAction: TextInputAction.search,
                cursorColor: Colors.grey[600],
                controller: widget.searchController,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                ),
                onSubmitted: (value) {
                  if (widget.searchController.text.isNotEmpty) {
                    context.read<SearchBloc>().add(
                          SearchRequested(
                            widget.searchController.text,
                            selectedSport,
                          ),
                        );
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 44),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  fillColor: Colors.white.withOpacity(0.9),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: primary2Color,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: primary2Color,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PopupMenuButton<String>(
                          onSelected: (String value) {
                            setState(() {
                              selectedSport = value;
                              hintText = l10n.searchTeams(
                                '${value[0].toUpperCase()}${value.substring(1)}',
                              );
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem<String>(
                                value: 'soccer',
                                child: Text('Soccer'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'basketball',
                                child: Text('Basketball'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'cricket',
                                child: Text('Cricket'),
                              ),
                            ];
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFFADD8E6), // Pale blue color
                          ),
                          offset: const Offset(
                            0,
                            40,
                          ), // Dropdown opens below the search bar
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.grey[800],
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: state.status == SearchStatus.succeed
                      ? IconButton(
                          onPressed: () {
                            context.read<SearchBloc>().add(
                                  const SearchStatusChanged(SearchStatus.none),
                                );
                          },
                          icon: const Icon(Icons.close, color: Colors.grey),
                        )
                      : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
