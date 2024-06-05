 export class Pagination {
    private readonly currentPage:number;
    private readonly limit:number;
    private readonly countAll:number;
    private readonly lastPage: number;
     private queries: any;
     private queryString: string = '';
     private readonly key:string;
     private readonly countThisPage:number;


    constructor(currentPage: number, limit: number, countAll: number,count:number,key="page") {
        this.currentPage = currentPage;
        this.limit = limit;
        this.countAll = countAll;
        this.lastPage = Math.ceil(countAll/limit);
        this.key=key;
        this.countThisPage = count;
    }

    makeQueryString() {
        if(this.queries) {
            if (this.queries.length == 0) {
                this.queryString = '';
                return;
            }
            this.queryString = '&';
            for (const query in this.queries) {
                if (query.includes(this.key)) {
                    continue;
                }
                this.queryString += `${query}=${this.queries[query]}&`
            }

            this.queryString = this.queryString.substring(0, this.queryString.length - 1)
        }
    }

    private makePrevIcon() {
        if(this.currentPage!=1) {
            return `<li class="page-item">
                <a
                        class="page-link"
                        href="?${this.key}=${this.currentPage-1}${this.queryString}"
                >
                <object data="/photo/svg/arrow-downp.svg"></object>
                        قبلی    
                </a>
            </li>`
        }
        return  ''
    }

    private makeFirstPage() {

        return ` <li class="page-item">
                <a class="page-link num${this.currentPage == 1 ? ' active' :''}" href="${this.currentPage == 1 ? '#' : `?${this.key}=1${this.queryString}`}">1</a>
            </li>`
    }

    private makeMoreFromFirstPage() {
        if(this.lastPage > 3 && this.currentPage > 2) {
            return '<span class="dot">...</span>'
        }

        return ''
    }

    private makeCurrentPage() {
        let currentAndMore  =''
        const pageNumber = this.currentPage ;

        if(pageNumber-1 !=1 && pageNumber+1 ==this.lastPage && pageNumber-1!=0) {
            currentAndMore+=`<li class="page-item}">
                <a class="page-link num" href="?${this.key}=${pageNumber-1}${this.queryString}">${pageNumber-1} </a>
            </li>
            `
        }


        if(this.lastPage > 1 && pageNumber  !=1 && this.currentPage < this.lastPage) {

            currentAndMore= `<li class="page-item">
                <a class="page-link num${this.currentPage != 1 ? ' active' : ''}" href="${this.currentPage == pageNumber ? '#' : `?${this.key}=${pageNumber}${this.queryString}`}">${pageNumber} </a>
            </li>`
        }

        if(pageNumber+1 < this.lastPage) {

            currentAndMore+=`<li class="page-item">
                <a class="page-link num" href="?${this.key}=${pageNumber+1}${this.queryString}">${pageNumber+1} </a>
            </li>
            `
        }
        
        return currentAndMore;
    }

    private makeMoreFromLastPage() {
        if(this.lastPage>3 && ((this.lastPage-this.currentPage)>2)) {
            return '<span class="dot">...</span>'
        }

        return ''
    }

    private makeLastPage() {
        if(
            this.lastPage!=1
        ) {
            return `<li class="page-item item">
                <a class="page-link num${this.currentPage == this.lastPage ? ' active' : ''}" href="${this.currentPage == this.lastPage ? '#' : `?${this.key}=${this.lastPage}${this.queryString}`}">${this.lastPage}</a>
            </li>`
        }
        return ''
    }

    private makeNextIcon() {
        if(this.currentPage!=this.lastPage) {
            return `<li class="page-item">
                <a class="page-link" href="?${this.key}=${this.currentPage+1}${this.queryString}" aria-label="Next">
                          بعدی
                          <object
                                      data="/photo/svg/arrow-downpr.svg"
                                      type=""
                              ></object>
                </a>
            </li>`
        }

        return  ''
    }

    getInformation() {
        if(this.countAll!=0)
            return `<span>نمایش ${this.countThisPage} از ${this.countAll}</span>`
    }

    make(queries:any) {
        this.queries = queries;
        this.makeQueryString()
        if (this.countAll != 0) {
            return `${this.makePrevIcon()}
                ${this.makeFirstPage()}
                ${this.makeMoreFromFirstPage()}
                ${this.makeCurrentPage()}
                ${this.makeMoreFromLastPage()}
                ${this.makeLastPage()}
                ${this.makeNextIcon()}
                `
        }

    }
}