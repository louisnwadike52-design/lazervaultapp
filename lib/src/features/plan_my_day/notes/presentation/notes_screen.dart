import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/plan_my_day/notes/domain/note.dart';
import 'package:lazervault/src/features/plan_my_day/notes/presentation/note_cubit.dart';

/// Standalone Notes list for Plan My Day. Provide its own NoteCubit at push.
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  static Route<void> route() => MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<NoteCubit>()..loadNotes(),
          child: const NotesScreen(),
        ),
      );

  static const _card = Color(0xFF1F1F1F);
  static const _muted = Color(0xFF9CA3AF);
  static const _purple = Color(0xFF4E03D0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: _card,
        elevation: 0,
        title: const Text('Notes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: Builder(
        builder: (ctx) => FloatingActionButton(
          backgroundColor: _purple,
          onPressed: () => _editNote(ctx),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading || state is NoteInitial) {
            return const Center(child: CircularProgressIndicator(color: _purple));
          }
          if (state is NoteError) {
            return Center(
              child: Text(state.message,
                  style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
            );
          }
          final notes = state is NotesLoaded ? state.notes : <Note>[];
          if (notes.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sticky_note_2_outlined,
                        color: _muted, size: 48.sp),
                    SizedBox(height: 14.h),
                    Text('No notes yet',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 6.h),
                    Text('Jot down anything — ideas, follow-ups, meeting notes.',
                        textAlign: TextAlign.center,
                        style:
                            GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 96.h),
            itemCount: notes.length,
            itemBuilder: (_, i) => _noteCard(context, notes[i]),
          );
        },
      ),
    );
  }

  Widget _noteCard(BuildContext context, Note note) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () => _editNote(context, note: note),
          onLongPress: () => _confirmDelete(context, note),
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (note.title.isNotEmpty)
                  Text(note.title,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600)),
                if (note.content.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(note.content,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: _muted, fontSize: 13.sp, height: 1.4)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _editNote(BuildContext context, {Note? note}) {
    final cubit = context.read<NoteCubit>();
    final titleC = TextEditingController(text: note?.title ?? '');
    final contentC = TextEditingController(text: note?.content ?? '');
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note != null ? 'Edit note' : 'New note',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 14.h),
              TextField(
                controller: titleC,
                style: GoogleFonts.inter(color: Colors.white),
                decoration: _dec('Title'),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: contentC,
                maxLines: 5,
                style: GoogleFonts.inter(color: Colors.white),
                decoration: _dec('Write your note…'),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: _purple),
                  onPressed: () {
                    final title = titleC.text.trim();
                    final content = contentC.text.trim();
                    if (title.isEmpty && content.isEmpty) {
                      Navigator.pop(ctx);
                      return;
                    }
                    cubit.saveNote(
                        id: note?.id,
                        title: title.isEmpty ? 'Untitled' : title,
                        content: content);
                    Navigator.pop(ctx);
                  },
                  child:
                      const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: _muted),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
      );

  void _confirmDelete(BuildContext context, Note note) {
    final cubit = context.read<NoteCubit>();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: const Text('Delete note', style: TextStyle(color: Colors.white)),
        content: const Text('Delete this note?',
            style: TextStyle(color: Color(0xFFD1D5DB))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: _muted)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444)),
            onPressed: () {
              cubit.deleteNote(note.id);
              Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
