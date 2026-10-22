
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';

class VideoUploadScreen extends StatefulWidget {
  final String sport;
  final String athleteId;

  const VideoUploadScreen({
    super.key,
    required this.sport,
    required this.athleteId,
  });

  @override
  State<VideoUploadScreen> createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  PlatformFile? _selectedVideo;
  bool _isLoading = false;

  Future<void> _chooseVideo() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4', 'mov', 'avi'],
        allowMultiple: false,
      );

      if (!mounted || result == null || result.files.isEmpty) return;

      setState(() => _selectedVideo = result.files.single);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not select video: $error')),
      );
    }
  }

  Future<void> _createAssessment() async {
    if (_selectedVideo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose a video first.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await ApiService.createAssessment(
        athleteId: widget.athleteId,
        sport: widget.sport,
      );

      if (!mounted) return;

      final assessment = response['assessment'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Assessment created successfully. '
            'Video selected locally: ${_selectedVideo!.name}',
          ),
        ),
      );

      debugPrint('Created assessment: $assessment');
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not create assessment: '
            '${error.toString().replaceFirst('Exception: ', '')}',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final video = _selectedVideo;

    return Scaffold(
      appBar: AppBar(title: const Text('Upload Performance Video')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.video_library_outlined,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              Text(
                'Upload Your ${widget.sport} Performance',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Select a video of your ${widget.sport} performance '
                'for assessment.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, height: 1.5),
              ),
              const SizedBox(height: 35),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Icon(
                      video == null
                          ? Icons.cloud_upload_outlined
                          : Icons.video_file_outlined,
                      size: 55,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      video?.name ?? 'No video selected',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    if (video != null)
                      Text(
                        '${(video.size / (1024 * 1024)).toStringAsFixed(2)} MB',
                        style: TextStyle(color: Colors.grey.shade600),
                      )
                    else
                      Text(
                        'MP4, MOV or AVI',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _isLoading ? null : _chooseVideo,
                icon: const Icon(Icons.video_file_outlined),
                label: const Text('Choose Video'),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      _isLoading || video == null ? null : _createAssessment,
                  icon: _isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.assignment_outlined),
                  label: Text(
                    _isLoading ? 'Creating Assessment...' : 'Create Assessment',
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Note: The selected video stays on your device. '
                'It is not uploaded or analyzed by the backend yet.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Text(
                'Tip: Record the athlete clearly with the full body visible.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
