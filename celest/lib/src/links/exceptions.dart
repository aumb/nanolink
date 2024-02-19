sealed class LinksException implements Exception {}

class InvalidLinkDataException extends LinksException {}

class DeleteLinkException extends LinksException {}

class CreateLinkException extends LinksException {}
