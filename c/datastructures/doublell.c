void insertfirst(int key, int data) {
	struct node *link = (struct node*) malloc(sizeof(struct node));
	link->key = key;
	link->data = data;

	if(isempty()) {
		// make it last
		last = link;
	}
	else {
		// update prev of first
		head->prev = link;
	}

	// point to old first
	link->next = head;
	head = link;
}

struct node* deletefirst() {
	struct node *temp = head;
	
	// if only one link
	if(head->next = NULL) {
		last = NULL;
	}
	else {
		head->next->prev = NULL;
	}
	head = head->next;
	return temp;
}

void insertlast(int key, int data) {
	// create link
	
	if(isempty()) {
		last = link;
	}
	else {
		last-next = link;
		last-prev = last;
	}
	last = link;
}

