namespace VocabularyJournal.Domain.Entities
{
	public class DailyTask
	{
		public int TaskId { get; set; }
		public int UserId { get; set; }
		public DateOnly Date { get; set; }
		public string? Source { get; set; }
		public string? Goal1 { get; set; }
		public string? Goal2 { get; set; }
		public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

		public User User { get; set; } = default!;
		public ICollection<WordEntry> WordEntries { get; set; } = new List<WordEntry>();
	}
}
