namespace VocabularyJournal.Contracts
{
	public record AttendanceDto(
	int UserId,
	string FullName,
	bool HasSubmitted,
	DateOnly Date
	);
}
