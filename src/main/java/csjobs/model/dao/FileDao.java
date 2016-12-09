package csjobs.model.dao;



import csjobs.model.File;
public interface FileDao {
	
	File getFile();

	File saveFiles(File file);

	File getFile(Long id);
	
	File getSingleFile(Long id);
}
