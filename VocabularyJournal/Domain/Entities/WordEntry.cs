namespace VocabularyJournal.Domain.Entities
{
	public class WordEntry
	{
		public int WordId { get; set; }
		public int TaskId { get; set; }
		public string Word { get; set; } = default!;
		public string? Meaning { get; set; }
		public string? OriginalPhrase { get; set; }
		public string? UserExample { get; set; }
		public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

		public DailyTask Task { get; set; } = default!;
	}
}
