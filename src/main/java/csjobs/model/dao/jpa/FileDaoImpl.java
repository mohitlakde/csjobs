package csjobs.model.dao.jpa;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import csjobs.model.dao.FileDao;
import csjobs.model.File;


@Repository
public class FileDaoImpl implements FileDao {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public csjobs.model.File getFile() {
		return entityManager.createQuery("from File order by id", File.class)
				.getSingleResult();
	}

	@Override
	@Transactional
	public File saveFiles(File file) {
		return entityManager.merge(file);
	}

	@Override
	public File getFile(Long id) {
		return entityManager.createQuery("from File order by id", File.class)
				.getSingleResult();
	}

	@Override
	public File getSingleFile(Long id) {
		entityManager.find( File.class, id );
		return null;
		
	
	}

}
