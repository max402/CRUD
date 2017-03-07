package crud.controller;

import crud.model.SearchString;
import crud.model.User;
import crud.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

import static javax.swing.text.StyleConstants.ModelAttribute;

@Controller
public class UserController {
    private UserService userService;

    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "users")
	public String usersRedirect(HttpServletRequest request) {
        request.getSession().setAttribute("userList", null);
        return "redirect:/users/page/1";
    }

    @RequestMapping(value = "/users/page/{page}", method = RequestMethod.GET)
    public String listUsers(@PathVariable("page")int page, Model model){
        PagedListHolder<?> pagedListHolder =  new PagedListHolder<>(this.userService.listUsers());
        pagedListHolder.setPage(page-1);
        pagedListHolder.setPageSize(4);
        model.addAttribute("listUsers", pagedListHolder.getPageList());
        model.addAttribute("page", pagedListHolder.getPage()+1);
        model.addAttribute("pages", pagedListHolder.getPageCount());

        model.addAttribute("user", new User());
        model.addAttribute("searchString", new SearchString());
        return "users";
    }

    @RequestMapping(value = "/searchResults", method = RequestMethod.POST)
    public String searchPage(@ModelAttribute("searchString")SearchString searchString, Model model){
        if(searchString.equals(""))return "redirect:/users/";
        List<User> searchResult = this.userService.searchUsers(searchString.getSearchString());
        model.addAttribute("foundUsers", searchResult);
        return "searchResults";
    }

//    @SuppressWarnings({ "rawtypes", "unchecked" })
//    @RequestMapping(value = "/users/page/{pageNumber}", method = RequestMethod.GET)
//    public String showPagedUsersPage(HttpServletRequest request, @PathVariable Integer pageNumber, Model uiModel) {
//        PagedListHolder<?> pagedListHolder = (PagedListHolder<?>) request.getSession().getAttribute("productList");
//        if (pagedListHolder == null) {
//        	pagedListHolder = new PagedListHolder(userService.listUsers());
//        	pagedListHolder.setPageSize(3);
//        } else {
//        	final int goToPage = pageNumber - 1;
//        	if (goToPage <= pagedListHolder.getPageCount() && goToPage >= 0) {
//        	pagedListHolder.setPage(goToPage);
//            }
//        }
//        request.getSession().setAttribute("userList", pagedListHolder);
//        // Pagination variables
//        int current = pagedListHolder.getPage() + 1;
//        int begin = Math.max(1, current - 3);
//        int end = Math.min(begin + 5, pagedListHolder.getPageCount());
//        int totalPageCount = pagedListHolder.getPageCount();
//        String baseUrl = "/users/page/";
//        uiModel.addAttribute("beginIndex", begin);
//        uiModel.addAttribute("endIndex", end);
//        uiModel.addAttribute("currentIndex", current);
//        uiModel.addAttribute("totalPageCount", totalPageCount);
//        uiModel.addAttribute("baseUrl", baseUrl);
//        uiModel.addAttribute("products", pagedListHolder);
//        return "users/list";
//    }

//    @RequestMapping(value = "users", method = RequestMethod.GET)
//    public String listUsers(HttpServletRequest request, Model model){
//        //User pm = new User();
//        PagedListHolder pagedListHolder = new PagedListHolder(this.userService.listUsers());
//        int page = ServletRequestUtils.getIntParameter(request, "p", 0);
//        pagedListHolder.setPage(page);
//        pagedListHolder.setPageSize(4);
//     //   model.put("pagedListHolder", pagedListHolder);
//        model.addAttribute("user", new User());
//      //  model.addAttribute("listUsers", this.userService.listUsers());
//        model.addAttribute("pagedListHolder", pagedListHolder);
//
//        return "users";
//    }


//    @RequestMapping(value = "users", method = RequestMethod.GET)
//    public String listUsers(Model model){
//        model.addAttribute("user", new User());
//        model.addAttribute("listUsers", this.userService.listUsers());
//
//        return "users";
//    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user){
        if(user.getUserId() == 0){
            this.userService.addUser(user);
        }else {
            this.userService.updateUser(user);
        }

        return "redirect:/users";
    }

    @RequestMapping("/remove/{id}")
    public String removeUser(@PathVariable("id") int id){
        this.userService.removeUser(id);

        return "redirect:/users";
    }

    @RequestMapping("edit/{id}")
    public String editUser(@PathVariable("id") int id, Model model){
        PagedListHolder<?> pagedListHolder =  new PagedListHolder<>(this.userService.listUsers());
        pagedListHolder.setPage(0);
        pagedListHolder.setPageSize(4);
        model.addAttribute("listUsers", pagedListHolder.getPageList());
        model.addAttribute("page", pagedListHolder.getPage()+1);
        model.addAttribute("pages", pagedListHolder.getPageCount());

        model.addAttribute("user", this.userService.getUserById(id));
        model.addAttribute("searchString", new SearchString());
        return "users";
    }

    @RequestMapping("userdata/{id}")
    public String userData(@PathVariable("id") int id, Model model){
        model.addAttribute("user", this.userService.getUserById(id));

        return "userdata";
    }
}
