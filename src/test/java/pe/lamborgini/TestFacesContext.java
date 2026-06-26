package pe.lamborgini;

import javax.faces.context.FacesContext;

public abstract class TestFacesContext extends FacesContext {

    public static void setCurrentInstance(FacesContext context) {
        FacesContext.setCurrentInstance(context);
    }

    public static void resetCurrentInstance() {
        FacesContext.setCurrentInstance(null);
    }
}
