package model;

import java.util.List;

public class WishlistWork {
    private int id;
    private String title;
    private String memo;
    private List<String> genres;
    
	public WishlistWork(int id, String title, String memo, List<String> genres) {
		this.id = id;
		this.title = title;
		this.memo = memo;
		this.genres = genres;
	}
	
	public WishlistWork() {
        
    }
	

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public List<String> getGenres() {
		return genres;
	}

	public void setGenres(List<String> genres) {
		this.genres = genres;
	}

    
}
