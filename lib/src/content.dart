part of dingus;

class Content {
	Map<String,ImageElement> _images = new Map();
	
	Content._make() {}
	
	ImageElement getImage(String name) {
		ImageElement img = _images[name];
		
		if (img!=null) return img;
		
		img = new ImageElement();
		img.src = "content/img/$name";
		
		_images[name]=img;
		
		return img;
	}
}