package example.shop.repos;

import example.shop.domain.ProductData;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ProductDataRepo extends CrudRepository<ProductData, Long> {
    List<ProductData> findByProductId(Integer id);
}
