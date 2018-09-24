void insertfirst(int key, int data) {
	struct node *link = (struct *node) malloc(sizeof(struct node));
	link->key = key;
	link->data = data;
	link->next = head;
	head = link;
}

struct node* deletefirst() {
	struct node *temp = (struct *node) malloc(sizeof(struct node));
	head = head->next;
	
	return temp;
}

void printlist() {
	struct node *ptr;
	printf("\n[");
	while(ptr != NULL) {
		printf("(%d. %d)", ptr->key, ptr->data);
		ptr = ptr->next;
	}
	printf("]");
}

struct node* deletenode(int x) {
	struct node *n = search(x);
	struct node *ptr = head;
	if (ptr == n) {
		ptr->next = n->next;
		return n;
	}
	else {
		while(ptr->next != n) {
			ptr = ptr->next;
		}
		ptr->next = n->next;
		return n;
	}
}

