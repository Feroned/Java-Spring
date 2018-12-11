package example.shop.repos;

import example.shop.domain.ProductEntity;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProductEntityRepo extends CrudRepository<ProductEntity, Long> {
    List<ProductEntity> findById(Integer id);
}
