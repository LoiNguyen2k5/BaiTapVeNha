package service;

import java.io.File;
import java.util.List;

import dao.CategoryDao;
import dao.CategoryDaoImpl;
import model.Category;
import service.CategoryService;
import util.Constant;

public class CategoryServiceImpl implements CategoryService {
    CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getCateId());
        
        // Nếu người dùng upload ảnh mới thì mới xử lý ảnh
        if (newCategory.getIcon() != null) {
            // Xóa ảnh cũ
            String oldIconName = oldCategory.getIcon();
            if (oldIconName != null) {
                File file = new File(Constant.DIR + "/" + oldIconName);
                if (file.exists()) {
                    file.delete();
                }
            }
            oldCategory.setIcon(newCategory.getIcon());
        }
        oldCategory.setCateName(newCategory.getCateName());
        
        categoryDao.edit(oldCategory);
    }

    @Override
    public void delete(int id) {
        // Trước khi xóa, lấy thông tin category để xóa ảnh
        Category category = categoryDao.get(id);
        if (category != null && category.getIcon() != null) {
            File file = new File(Constant.DIR + "/" + category.getIcon());
            if (file.exists()) {
                file.delete();
            }
        }
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }
}