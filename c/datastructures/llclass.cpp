class node {
	public:
		int data;
		node* next;
		
		node() {
			data = 0;
			next = NULL;
		}

		node(int x) {
			data = x;
			next = NULL;
		}
};
