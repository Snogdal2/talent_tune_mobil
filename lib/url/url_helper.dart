Uri uriHelper(String path) {
  const authority = 'http://localhost:3001';
  return Uri.https(
    authority,
    path,
  );
}
