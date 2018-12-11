package example.shop.repos;

import example.shop.domain.ProductMedia;
import org.springframework.data.repository.CrudRepository;

public interface ProductMediaRepo extends CrudRepository<ProductMedia, Long> {
}
