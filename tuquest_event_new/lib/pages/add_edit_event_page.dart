import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditEventPage extends StatefulWidget {
  final Function({
    required String title,
    required String description,
    required DateTime start,
    required DateTime end,
    required String? imagePath,
  }) onSave;

  const AddEditEventPage({super.key, required this.onSave});

  @override
  State<AddEditEventPage> createState() => _AddEditEventPageState();
}

class _AddEditEventPageState extends State<AddEditEventPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  File? _imageFile;
  String? _imageUrl;

  Future<void> _pickDate({required bool isStart}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? DateTime.now() : (_startDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = picked;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
        _imageUrl = null;
      });
    }
  }

  void _setImageFromUrl(String url) {
    setState(() {
      _imageUrl = url;
      _imageFile = null;
    });
  }

  void _saveEvent() {
    if (_titleController.text.isEmpty || _startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill required fields.')),
      );
      return;
    }

    widget.onSave(
      title: _titleController.text,
      description: _descController.text,
      start: _startDate!,
      end: _endDate!,
      imagePath: _imageFile?.path ?? _imageUrl,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add/Edit Event')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Event Name *'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Details'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text(_startDate == null
                        ? 'Start Date *'
                        : 'Start: ${_startDate!.toLocal().toString().split(' ')[0]}'),
                    leading: const Icon(Icons.calendar_today),
                    onTap: () => _pickDate(isStart: true),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(_endDate == null
                        ? 'End Date *'
                        : 'End: ${_endDate!.toLocal().toString().split(' ')[0]}'),
                    leading: const Icon(Icons.calendar_today),
                    onTap: () => _pickDate(isStart: false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text('Image'),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImageFromGallery,
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onSubmitted: _setImageFromUrl,
                    decoration: const InputDecoration(
                      labelText: 'or enter image URL',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_imageFile != null)
              Image.file(_imageFile!, height: 150)
            else if (_imageUrl != null)
              Image.network(_imageUrl!, height: 150)
            else
              const Text('No image selected'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEvent,
              child: const Text('Save Event'),
            ),
          ],
        ),
      ),
    );
  }
}
